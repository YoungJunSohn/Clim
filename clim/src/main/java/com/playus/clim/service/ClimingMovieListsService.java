package com.playus.clim.service;


import java.util.List; 
import com.playus.clim.vo.ClimingMovieList;

public interface ClimingMovieListsService {

	void insertPlayedMovie(int roomNo, int movieNo);
	public List<ClimingMovieList> myPageClimingList(int memberNo);

	
}
