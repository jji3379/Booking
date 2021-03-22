package com.acorn5.booking.review.dao;

import java.util.List;

import com.acorn5.booking.review.dto.ReviewCommentDto;

public interface ReviewCommentDao {
	// by남기, 댓글 목록 얻어오기_210303
	public List<ReviewCommentDto> getList(ReviewCommentDto dto);
	// by남기, 댓글 추가_210303
	public void insert(ReviewCommentDto dto);
	// by남기, 댓글 수정_210303
	public void update(ReviewCommentDto dto);
	// by남기, 댓글 삭제_210303
	public void delete(int num);
	// by남기, 댓글의 시퀀스값(글번호) 를 리턴하는 메소드_210303
	public int getSequence();
	// by남기, 댓글 하나의 정보를 리턴하는 메소드_210303
	public ReviewCommentDto getData(int num);
	// by남기, 댓글의 갯수를 리턴하는 메소드_210303
	public int getCount(int ref_group);
	//by욱현.회원탈퇴시 회원의  댓글 삭제위해_21323
	public void delete2(String writer);
}
