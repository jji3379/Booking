package com.acorn5.booking.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.BookDto;

//by 준익, 네이버 도서 api 관련 서비스 관리 인터페이스_2021.02.26
public interface BookService {
	
	//by 준익, 네이버 도서 api 카테고리별 검색 및 페이징 메소드 
	public List<BookDto> pagingCategory(String d_isbn, int display, int start, String d_catg, HttpServletRequest request, ModelAndView mav);

}
