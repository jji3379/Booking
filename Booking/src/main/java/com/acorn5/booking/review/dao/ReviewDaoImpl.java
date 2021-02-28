package com.acorn5.booking.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.review.dto.ReviewDto;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	// by남기._2021224
	
	// 빈에서 핵심 의존객체(SqlSession)를 DI 할 준비를 한다.
	@Autowired
	private SqlSession session;
	
	// 새로운 리뷰 추가하는 메소드
	@Override
	public void insert(ReviewDto dto) {
		session.insert("review.insert", dto);
	}
	
	// 리뷰 하나의 정보를 가져오는 메소드
	@Override
	public ReviewDto getData(int num) {
		ReviewDto dto=session.selectOne("review.getData", num);
		return dto;
	}
	
	// 리뷰 전체 리스트를 가져오는 메소드
	@Override
	public List<ReviewDto> getList(ReviewDto dto) {
		/*
		 *  parameterType => ReviewDto
		 *  
		 *  parameterType  에는 페이징 처리를 위한 startRowNum 과 endRowNum 이 들어 있고
		 *  
		 *  title  검색이면 title  필드에 검색 키워드가 들어있다.
		 *  writer 검색이면 writer 필드에 검색 키워드가 들어있다.
		 *  title+content 검색이면 title and content 필드에 검색 키워드가 들어 있다.
		 *  검색 키워드가 없으면 title,writer,content 필드는 모두 null 이다.
		 *  
		 *  resultType => ReviewDto 
		 */
		List<ReviewDto> list=session.selectList("review.getList", dto);
		return list;
	}
	
	// 리뷰의 갯수를 가져오는 메소드
	@Override
	public int getCount(ReviewDto dto) {
		/*
		 *  parameterType => ReviewDto
		 *  parameterType  에는 검색키워드가 존재한다면 들어 있다.
		 *  
		 *  resultType => int
		 */
		int count=session.selectOne("review.getCount", dto);
		return count;
	}
	
	// 리뷰의 조회수를 가져오는 메소드
	@Override
	public void addViewCount(int num) {
		session.update("review.addViewCount", num);
	}

}