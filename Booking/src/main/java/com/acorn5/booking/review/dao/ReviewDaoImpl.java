package com.acorn5.booking.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.exception.DBFailException;
import com.acorn5.booking.review.dto.ReviewDto;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
	// by남기, 빈에서 핵심 의존객체(SqlSession)를 DI 할 준비를 한다_210303
	@Autowired
	private SqlSession session;
	
	// by남기, 새로운 리뷰 추가하는 메소드_210303

	@Override
	public void insert(ReviewDto dto) {
		session.insert("review.insert", dto);
	}
	// by남기, 리뷰를 수정하는 메소드_210303
	@Override
	public void update(ReviewDto dto) {
		session.update("review.update", dto);
	}
	// by남기, 리뷰를 삭제하는 메소드_210303
	@Override
	public void delete(int num) {
		// by남기, 삭제된 row 의 갯수를 얻어낸다 _210303
		int count=session.delete("review.delete", num);
		if(count==0) {// by남기, 0 이면 삭제 실패이다_210303
			// by남기, 삭제 실패하면 DBFailException 으로 메세지를 떠넘긴다_210303
			throw new DBFailException(num+" 번 글을 삭제 할수가 없습니다.");
		}
	}
	// by남기, 리뷰 하나의 정보를 가져오는 메소드_210303
	@Override
	public ReviewDto getData(int num) {
		ReviewDto dto=session.selectOne("review.getData", num);
		return dto;
	}
	
	// by남기, 리뷰 전체 리스트를 가져오는 메소드_210303
	@Override
	public List<ReviewDto> getList(ReviewDto dto) {
		/*
		 *  by남기, 
		 *  parameterType => ReviewDto
		 *  
		 *  parameterType  에는 페이징 처리를 위한 startRowNum 과 endRowNum 이 들어 있고
		 *  
		 *  title  검색이면 title  필드에 검색 키워드가 들어있다.
		 *  writer 검색이면 writer 필드에 검색 키워드가 들어있다.
		 *  title+content 검색이면 title and content 필드에 검색 키워드가 들어 있다.
		 *  검색 키워드가 없으면 title,writer,content 필드는 모두 null 이다.
		 *  
		 *  resultType => ReviewDto _210303

		 */
		List<ReviewDto> list=session.selectList("review.getList", dto);
		return list;
	}
	
	// by남기, 리뷰의 갯수를 가져오는 메소드_210303
	@Override
	public int getCount(ReviewDto dto) {
		/*
		 * 	by남기, 
		 *  parameterType => ReviewDto
		 *  parameterType  에는 검색키워드가 존재한다면 들어 있다.
		 *  
		 *  resultType => int _210303
		 */
		int count=session.selectOne("review.getCount", dto);
		return count;
	}
	
	// by남기, 리뷰의 조회수를 가져오는 메소드_210303
	@Override
	public void addViewCount(int num) {
		session.update("review.addViewCount", num);
	}
}

