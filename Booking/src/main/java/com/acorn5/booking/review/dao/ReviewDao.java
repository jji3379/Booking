package com.acorn5.booking.review.dao;

import java.util.List;

import com.acorn5.booking.review.dto.ReviewDto;

public interface ReviewDao {
	
	// by남기, 리뷰 추가_210303
	public void insert(ReviewDto dto);
	// by남기, 리뷰 수정_210303
	public void update(ReviewDto dto);
	// by남기, 리뷰 삭제_210303
	public void delete(int num);
	// by남기, 리뷰 하나의 정보 얻어오기_210303
	public ReviewDto getData(int num);
	// by남기, 리뷰 목록 얻어오기 (페이징 처리와 검색 키워드를 고려한 목록)_210303
	public List<ReviewDto> getList(ReviewDto dto);
	// by남기, 리뷰의 갯수 얻어오기(검색 키워드에 해당하는 갯수)_210303
	public int getCount(ReviewDto dto);
	// by남기, 리뷰 조회수 올리기_210303
	public void addViewCount(int num);
	// by욱현. 내가 쓴 리뷰 모아보기_2021309
		public List<ReviewDto> getMyReview(ReviewDto dto);
}