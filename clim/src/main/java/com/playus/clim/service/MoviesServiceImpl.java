package com.playus.clim.service;

<<<<<<< HEAD
import java.io.ObjectOutputStream.PutField;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
=======
import java.util.HashMap;
import java.util.List;
import java.util.Map;
>>>>>>> master

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.playus.clim.dao.ActorsDAO;
import com.playus.clim.dao.DirectorsDAO;
import com.playus.clim.dao.MoviesDAO;
import com.playus.clim.dao.SteelCutsDAO;
import com.playus.clim.vo.Movie;
import com.playus.clim.vo.StealCut;

@Service
public class MoviesServiceImpl implements MoviesService{
	
	@Autowired
	private MoviesDAO moviesDAO;
	@Autowired
<<<<<<< HEAD
	private SteelCutsDAO steelcutsDAO;
=======
	private ActorsDAO actorsDAO;
	@Autowired
	private DirectorsDAO directorsDAO;
>>>>>>> master

	@Override
	public List<Movie> getSearchResultForcliming(String title) {
		return moviesDAO.searchMovieListForCliming(title);
	}
	
<<<<<<< HEAD
/*김근경 시작*/
	//index에서 끌림작 1위~30위
	@Override
	public List<Movie> getClimedList() {
		List<Movie> movies = moviesDAO.indexClimedList();

		for(Movie movie: movies) {
			
			int movieNo = movie.getNo();		
			int srcNumber= steelcutsDAO.selectTotalForMovieId(movieNo);
			
			int randomR= (int)(Math.random()*srcNumber)+1;//movieNo의 스틸컷을 랜덤하게 출력하기 위해
			
			StealCut stealCut = new StealCut();
			stealCut.setRandomR(randomR);
			stealCut.setMovieNo(movieNo);
			
			movie.setRecSteal(steelcutsDAO.selectOneForClimed(stealCut));
		}
		return movies;
	}
	
	
	//index에서 추천작1~3
	@Override
	public Map<String, Object> getRecommandationList() {
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		map.put("recOne",moviesDAO.indexRecommandationListOne());//추천작1
		map.put("recTwo",moviesDAO.indexRecommandationListTwo());//추천작2
		map.put("recThree",moviesDAO.indexRecommandationListThree());//추천작3
		
		return map;
	}
/*김근경 끝*/
=======
	@Override
	public Map<String, Object> getMovieTrailer(int no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movie",moviesDAO.selectMovieTrailer(no));
		map.put("directors",directorsDAO.selectDirectorForMovie(no));
		map.put("actors",actorsDAO.selectListForMovie(no));
		return map;
	}
>>>>>>> master

}
