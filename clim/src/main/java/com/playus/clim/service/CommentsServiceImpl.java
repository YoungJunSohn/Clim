package com.playus.clim.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.playus.clim.dao.CommentsDAO;
import com.playus.clim.util.PaginateUtil;
import com.playus.clim.vo.Comment;
import com.playus.clim.vo.PageVO;

@Service
public class CommentsServiceImpl implements CommentsService{
	/* 0802 홍성표 */
	@Autowired
	private CommentsDAO commentsDAO;
	@Autowired
	private PaginateUtil paginateUtil;
	
	@Override
	public Map<String, Object> getMyComments(int memberNo, int page) {
		Map<String, Object> map = new ConcurrentHashMap<String, Object>();
		
		PageVO pageVO = new PageVO(page, 10, memberNo);
		
		int total = commentsDAO.myWriteCommentsTotal(memberNo);
		
		map.put("comments", commentsDAO.myWriteCommentsList(pageVO));
		map.put("paginate", paginateUtil.getPaginate(page, total, 10, 5, "/ajax/member"+memberNo+"comments"));
		
		return map;
	}
	
	@Override
	public int insertComment(Comment comment) {
		// TODO Auto-generated method stub
		return commentsDAO.insertComment(comment);
	}

}
