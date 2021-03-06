package com.playus.clim.util;

import java.awt.Dimension;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.xuggle.xuggler.Global;
import com.xuggle.xuggler.ICodec;
import com.xuggle.xuggler.IContainer;
import com.xuggle.xuggler.IError;
import com.xuggle.xuggler.IPacket;
import com.xuggle.xuggler.IRational;
import com.xuggle.xuggler.IStream;
import com.xuggle.xuggler.IStreamCoder;
import com.xuggle.xuggler.IVideoPicture;
import com.xuggle.xuggler.IVideoResampler;
import com.xuggle.xuggler.video.ConverterFactory;
import com.xuggle.xuggler.video.IConverter;


@Component
public class SnapshotCreateUtil {

	private final Logger logger = LoggerFactory.getLogger(SnapshotCreateUtil.class);
	
	/**
	 * 
	 * @param inputFilename 비디오파일 경로
	 * @param timestamp 스크린샷을 찍을 시간(밀리세컨 : Long형)
	 * @param outputDir 저장할 경로
	 * @param snapshotPrefix 저장할 폴더(File형)
	 * @param maxWidth 최대 너비
	 * @param maxHeight 최대 높이
	 * @throws Exception
	 */
	public void makeSnapshots(String inputFilename,  Long timestamp, File outputDir, String snapshotPrefix, Integer maxWidth, Integer maxHeight) throws Exception{
		if (!IVideoResampler.isSupported(IVideoResampler.Feature.FEATURE_COLORSPACECONVERSION)){
			logger.info("IVideoResampler not available");
			throw new Exception(); 
		}
		snapshotPrefix = snapshotPrefix!=null ? snapshotPrefix : "snapshot_";

		//Resources that must be closed		
		IStreamCoder videoCoder = null;		
		IContainer container = null;		
		
		container = IContainer.make();
		if (container.open(inputFilename, IContainer.Type.READ, null) < 0){
			throw new Exception();
		}
		
		try{
			int streamIndex = findVideoStreamIndex(container);
			if (streamIndex < 0)
				throw new Exception("could not find video stream in container: "+ inputFilename);
			
			IStream stream = container.getStream(streamIndex);
			
			// get the pre-configured decoder that can decode this stream;
			videoCoder = stream.getStreamCoder();
			
			// Now we have found the video stream in this file. Let's open up
			// our decoder so it can do work			
			if (videoCoder.open(null, null) < 0){
				throw new Exception("could not open video decoder for container: "+ inputFilename);
			}
			
			//Calculate the final output dimensions if maximum values for width and height have been specified 
			Dimension outputDim = computeOutputDimension(videoCoder.getWidth(), videoCoder.getHeight(), maxWidth, maxHeight);
			
			//If resize is required we will use a IVideoResampler
			boolean resizeRequired = videoCoder.getWidth()!=outputDim.width || videoCoder.getHeight()!=outputDim.height;
			
			if(resizeRequired && logger.isInfoEnabled()){
				logger.info("Video snapshots will be resized to {}x{}", outputDim.width, outputDim.height);
			}
			
			IConverter converter =  ConverterFactory.createConverter(ConverterFactory.XUGGLER_BGR_24, videoCoder.getPixelType(), 
					videoCoder.getWidth(), videoCoder.getHeight(),
					outputDim.width, outputDim.height);
			/*
			 * Reminder
			 * PTS : Presentation Time Stamp (in Microseconds). Not necessarily the same timebase used in the stream (seeking) 
			 */			
			//This is the timebase used for seeking
			IRational videoTimeBase = stream.getTimeBase();
			//This is the timebase of our timestamps.  			
			IRational timestampsTimeBase = IRational.make(1, 1000);
			final double frameRate = videoCoder.getFrameRate().getDouble();
			final long frameInterval = (long) (Global.DEFAULT_PTS_PER_SECOND / frameRate); // In PTS
			final long startTime = container.getStartTime();// In microseconds			
			
			if(logger.isDebugEnabled()){
				logger.debug("Video time base = {}", videoTimeBase);
				logger.debug("Video frame rate = {}", frameRate);
				logger.debug("Video start time = {}", startTime);
			}
			
			// We allocate a new picture to get the data out of Xuggle
			IVideoPicture picture = IVideoPicture.make(videoCoder.getPixelType(), videoCoder.getWidth(), videoCoder.getHeight());
			//And a IPacket to keep the packets 
			IPacket packet = IPacket.make();
			
				//In the video timebase. We convert from the timestamps timebase to the video timebase
				long seekTimestamp = startTime +  videoTimeBase.rescale(timestamp, timestampsTimeBase);
				//In PTS units. Used to find the matching frame
				long targetPTS = Math.round(timestamp/1000.0 * Global.DEFAULT_PTS_PER_SECOND);				
				boolean decodeVideo = true;				
				
				if(logger.isDebugEnabled()){
					logger.debug("Making snapshot at {}ms. Seeking to {} ts", timestamp, seekTimestamp);
				}
				
				seekVideo(container, streamIndex, seekTimestamp);				
				
				// Now, we start walking through the container looking at each packet.
				while (decodeVideo && container.readNextPacket(packet) >= 0) {
					
					// Now we have a packet, let's see if it belongs to our video stream
					if(packet.getStreamIndex()!= streamIndex){
						continue; //Skip this packet
					}
					
					int offset = 0;
					while (decodeVideo && offset < packet.getSize()) {
						// Now, we decode the video, checking for any errors.
						int bytesDecoded = videoCoder.decodeVideo(picture, packet, offset);
						if (bytesDecoded < 0) {
							convertErrorToException(bytesDecoded, "Error decoding video. Reason:");
						}
						offset += bytesDecoded;
						
						// Some decoders will consume data in a packet, but will not
						// be able to construct a full video picture yet. Therefore
						// you should always check if you got a complete picture
						// from the decoder.
						if (picture.isComplete()) {
							
							//Check if the current picture is within the desired time frame
							long diff = picture.getPts()-targetPTS;	
							if(Math.abs(diff)<=frameInterval){
								
								if(logger.isDebugEnabled()){
									double actual = ((double) picture.getPts())/ Global.DEFAULT_PTS_PER_SECOND;
									double requested = timestamp / 1000.0;
									logger.debug("Video within desired position. Requested= {}s Actual={}",requested, actual);
								}									
								
								BufferedImage image = converter.toImage(picture);
								
								String filename = snapshotPrefix+timestamp+".jpg";
								File targetFile = new File(outputDir,filename);
								logger.info("Saving snapshot as {}",targetFile);																								
								try {
									ImageIO.write(image, "jpg", targetFile);
								} catch (IOException e) {
									throw new Exception("Failed to save snapshot", e);
								}
								decodeVideo= false;
							}//Check if we are far ahead of the desired timestamp. Using one second threshold
							else if(diff>frameInterval*frameRate){
								double actual = ((double) picture.getPts())/ Global.DEFAULT_PTS_PER_SECOND;
								logger.warn("Failed to seek to desired position. Current position is {}s",actual);
								decodeVideo = false;
							}
						}
					}				 						
				}
			
		}
		finally {
			if (videoCoder != null) {
				videoCoder.close();
				videoCoder = null;
			}
			if (container != null) {
				container.close();
				container = null;
			}
		}				
	}
	
	private int findVideoStreamIndex(IContainer container){
		int numStreams = container.getNumStreams();		
		for (int i = 0; i < numStreams; i++) {
			IStream stream = container.getStream(i);

			// get the pre-configured decoder that can decode this stream;
			IStreamCoder coder = stream.getStreamCoder();
			if (coder.getCodecType() == ICodec.Type.CODEC_TYPE_VIDEO) {
				return i;										
			}
		}
		return -1;
	}
	
	private Dimension computeOutputDimension(int originalWidth, int originalHeight, Integer maxWidth, Integer maxHeight){
		int outputWidth;
		int outputHeight;		
		if(maxWidth!=null && maxHeight!=null){
			double videoWidth = originalWidth;
			double videoHeight = originalHeight;			
			double ratio = Math.min( maxWidth/videoWidth, maxHeight/videoHeight);
			outputWidth = (int) (videoWidth * ratio);
			outputHeight = (int) (videoHeight * ratio);
		}
		else{
			outputWidth = originalWidth;
			outputHeight = originalHeight;
		}
		return new Dimension(outputWidth, outputHeight);
	}
	
	private void seekVideo(IContainer container, int videoStreamIndex, long seekTimestamp) throws Exception{
		int seekRes = 0;			
		seekRes = container.seekKeyFrame(videoStreamIndex, Long.MIN_VALUE,seekTimestamp, seekTimestamp, 0);
		if (seekRes < 0){
			convertErrorToException(seekRes, "Error performing seek. Reason:");
		}		
	}
	
	private void convertErrorToException(int errorCode, String message) throws Exception{
		IError error = IError.make(errorCode);
		throw new Exception(message + error.getDescription());
	}	
	
}