package com.playus.clim.service;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;

import com.playus.clim.dao.MembersDAO;
import com.playus.clim.vo.Member;

import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import com.playus.clim.dao.MembersDAO;
import com.playus.clim.dao.SubscribesDAO;
import com.playus.clim.vo.Member;
import com.playus.clim.vo.Subscribe;

@Service
public class MembersServiceImpl implements MembersService{
	
	@Autowired
	private MembersDAO membersDAO;
	@Autowired
	private SubscribesDAO subscribesDAO;

	
	/* hsp */
	@Override
	public Member getMemberByNo(int no) {  
		return membersDAO.selectOneByNo(no);
	}
	
	//로그인
	@Override
	public Map<String, Object> login(Member member, HttpSession session) { 
		Member loginMember = membersDAO.selectLogin(member);

		session.setAttribute("loginMember", loginMember);

		System.out.println("서비스" + loginMember);
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();

		if (loginMember != null && loginMember.getUuid()==null) {
			System.out.println(map);
			map.put("loginMember", loginMember);
		} else {
			map.put("loginMember", 0);
		}
		return map;
	}

	@Override
	public int getCheckId(String email) {
		return membersDAO.checkId(email);
	}
	@Override
	public int getCheckNickname(String nickname) {
		// TODO Auto-generated method stub
		return membersDAO.checkNickname(nickname);
	}
	
	@Override
	public int insertMember(Member member) {
		// TODO Auto-generated method stub
		return membersDAO.insertMember(member);
	}
	
	@Override
	public Map<String, Object> UUIDUpdate(Member member) {
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();

		UUID uuid = UUID.randomUUID();
		String code = uuid.toString();
		//System.out.println("uuid실행될까?"+code);
		member.setUuid(code);
		membersDAO.UUIDUpdate(member);
		//System.out.println("wpqkf!");
		
		map.put("member",member);
		
		return map;
	}
	
	
	@Override
	public int updateInfo(Member member) {
		// TODO Auto-generated method stub
		return membersDAO.updateInfo(member);
	}
	public Map<String, Object> pwdUpdate(Member member) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		System.out.println(member.getNo()+"22222211111111111111111111111");
		
		String uuid = "";
		member.setUuid(uuid);
		System.out.println(uuid+"uuid 초기화");
		membersDAO.pwdUpdate(member);
		System.out.println(member.getPwd());
		
		return map;
	}
	
	
	@Override
	public Member myPageMember(int memberNo,int loginMember) {
		Member member = membersDAO.myPageMemberSelectOne(memberNo);
		Subscribe subscribe = new Subscribe();
		subscribe.setFollowing(loginMember);
		subscribe.setFollower(memberNo);
		member.setSubscribeCheck(1==subscribesDAO.subscribesCheck(subscribe));
	return member;
	}
	
	@Override
	public List<Member> myPageMovieForActors(int no) {
		return membersDAO.myPageMovieForActors(no);
	}
	
	@Override
	public List<Member> myPageMovieFordirectors(int no) {
		return membersDAO.myPageMovieFordirectors(no);
	}
	
	@Override
	public List<Member> myPageMovieForGenres(int no) {
		return membersDAO.myPageMovieForGenres(no);
	}
	
	@Override
	public List<Member> myPageMovieForStriming(int no) {
		return membersDAO.myPageMovieForStriming(no);
	}
}

