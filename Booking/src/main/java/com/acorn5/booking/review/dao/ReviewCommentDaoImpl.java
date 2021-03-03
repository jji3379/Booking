package com.acorn5.booking.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.review.dto.ReviewCommentDto;

@Repository
public class ReviewCommentDaoImpl implements ReviewCommentDao{
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ReviewCommentDto> getList(ReviewCommentDto dto) {
		List<ReviewCommentDto> list=
				session.selectList("reviewComment.getList", dto);
		return list;
	}

	@Override
	public void insert(ReviewCommentDto dto) {
		session.insert("reviewComment.insert", dto);
	}

	@Override
	public void update(ReviewCommentDto dto) {
		session.update("reviewComment.update", dto);
	}

	@Override
	public void delete(int num) {
		//댓글 삭제는 deleted 칼럼의 내용을 'yes' 로 수정하는 작업을 한다. 
		session.update("reviewComment.delete", num);
	}
	/*
	 *  새로운 댓글을 저장한 직후에 바로 해당 댓글의 번호가 필요 하기 때문에
	 *  댓글의 글번호는 미리 얻어내서 작업을 해야한다. 
	 *  따라서 새 댓글의 글번호를 리턴해주는 메소드가 필요하다. 
	 */
	@Override
	public int getSequence() {
		/*  parameterType => x
		 *  resultType => int 
		 *  sql id => getSequence
		 */
		int seq=session.selectOne("reviewComment.getSequence");
		return seq;
	}

	@Override
	public ReviewCommentDto getData(int num) {
		return session.selectOne("reviewComment.getData", num);
	}

	@Override
	public int getCount(int ref_group) {
		return session.selectOne("reviewComment.getCount", ref_group);
	}
}
