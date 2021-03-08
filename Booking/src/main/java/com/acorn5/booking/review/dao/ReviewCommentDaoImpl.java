package com.acorn5.booking.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.dto.ReviewCommentDto;

@Repository
public class ReviewCommentDaoImpl implements ReviewCommentDao{
	
	// by남기, 빈에서 핵심 의존객체(SqlSession)를 DI 할 준비를 한다_210303
	@Autowired
	private SqlSession session;
	
	// by남기, 리뷰 댓글 전체를 리턴해주는 메소드_210303
	@Override
	public List<ReviewCommentDto> getList(ReviewCommentDto dto) {
		List<ReviewCommentDto> list=
				session.selectList("reviewComment.getList", dto);
		return list;
	}
	
	// by남기, 리뷰 댓글을 추가하는 메소드_210303
	@Override
	public void insert(ReviewCommentDto dto) {
		session.insert("reviewComment.insert", dto);
	}
	
	// by남기, 리뷰 댓글을 수정하는 메소드_210303
	@Override
	public void update(ReviewCommentDto dto) {
		session.update("reviewComment.update", dto);
	}
	
	// by남기, 리뷰 댓글을 삭제하는 메소드_210303
	@Override
	public void delete(int num) {
		// by남기, 댓글 삭제는 deleted 칼럼의 내용을 'yes' 로 수정하는 작업을 한다_210303 
		session.update("reviewComment.delete", num);
	}
	
	/*
	 *  by남기, 
	 *  새로운 댓글을 저장한 직후에 바로 해당 댓글의 번호가 필요 하기 때문에
	 *  댓글의 글번호는 미리 얻어내서 작업을 해야한다. 
	 *  따라서 새 댓글의 글번호를 리턴해주는 메소드가 필요하다_210303
	 */
	@Override
	public int getSequence() {
		/*  
		 *  by남기,
		 *  parameterType => x
		 *  resultType => int
		 *  sql id => getSequence _210303
		 */
		int seq=session.selectOne("reviewComment.getSequence");
		return seq;
	}
	
	// by남기, 리뷰 댓글 하나의 정보를 리턴하는 메소드_210303
	@Override
	public ReviewCommentDto getData(int num) {
		return session.selectOne("reviewComment.getData", num);
	}
	
	// by남기, 리뷰 댓글의 갯수를 리턴하는 메소드_210303
	@Override
	public int getCount(int ref_group) {
		return session.selectOne("reviewComment.getCount", ref_group);
	}
}
