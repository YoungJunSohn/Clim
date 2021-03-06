package com.playus.clim.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.playus.clim.vo.Event;

@Repository
public class EventsDAOImpl implements EventsDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Event> eventList(int memberNo) {
		return session.selectList("events.eventList",memberNo);
	}
	
	@Override
	public int eventInsert(Event event) {
		return session.insert("events.insert",event);
	}
	
	@Override
	public int eventDelete(int no) {
		return session.delete("events.delete",no);
	}
	
}
