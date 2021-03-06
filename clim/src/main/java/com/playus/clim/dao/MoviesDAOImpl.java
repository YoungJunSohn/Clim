package com.playus.clim.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.playus.clim.vo.Movie;

@Repository
public class MoviesDAOImpl implements MoviesDAO{

	@Autowired
	private SqlSession session;

	@Override
	public List<Movie> searchMovieListForCliming(String title) {
		return session.selectList("movies.searchMovieListForCliming", "%"+title+"%");
	}
/*김근경 시작*/
	
	//index에서 끌림작 1위~30위
	@Override
	public List<Movie> indexClimedList() {
		return session.selectList("movies.indexClimedList");
	}

	//index에서 추천1
	@Override
	public List<Movie> indexRecommandationListOne() {
		return session.selectList("movies.indexRecommandationListOne");
	}
	
	//index에서 추천2
	@Override
	public List<Movie> indexRecommandationListTwo() {
		return session.selectList("movies.indexRecommandationListTwo");
	}
	
	//index에서 추천3
	@Override
	public List<Movie> indexRecommandationListThree() {
		return session.selectList("movies.indexRecommandationListThree");
	}
	
	//index에서 추천4
	@Override
	public List<Movie> indexRecommandationListFour() {
		return session.selectList("movies.indexRecommandationListFour");
	}
	
	//index에서 장르1(드라마)
	@Override
	public List<Movie> indexGenreListOne() {
		return session.selectList("movies.indexGenreListOne");
	}
	//index에서 장르2(액션)
	@Override
	public List<Movie> indexGenreListTwo() {
		return session.selectList("movies.indexGenreListTwo");
	}
	//index에서 장르3(모험)
	@Override
	public List<Movie> indexGenreListThree() {
		return session.selectList("movies.indexGenreListThree");
	}
	
	@Override
	public String selectPoster(String src) {
		return session.selectOne("movies.selectPoster",src);
	}
	
/*김근경 끝*/
	
	@Override
	public Movie selectMovieTrailer(int no) {
		return session.selectOne("movies.selectMovieTrailer",no);
	}
	
	@Override
	public Movie selectMovie(int movieNo) {
		return session.selectOne("movies.selectMovie", movieNo);
	}
	@Override
	public Movie movieSelectOne(int no) {
		// TODO Auto-generated method stub
		return session.selectOne("movies.movieSelectOne", no);
	}
}
