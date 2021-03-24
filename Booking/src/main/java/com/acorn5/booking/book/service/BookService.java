package com.acorn5.booking.book.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;

//by 준익, 네이버 도서 api 관련 서비스 관리 인터페이스_2021.02.26
@Service
public interface BookService {
	
	//by 준익, 네이버 도서 api 카테고리별 검색 및 페이징 메소드_2021.02.28
	public List<BookDto> pagingCategory(String d_cont, int display, int start, String d_catg, HttpServletRequest request, ModelAndView mView, String sort);
	//by 준영, 네이버 도서 api 판매량순 인기도서 검색 메소드_210228
	public List<BookDto> bestSeller(String d_cont,int display, int start, String sort);
	//by 준영, 네이버 도서 api 해당 isbn 값 도서 검색 메소드_210228
	public List<BookDto> bookDetail(String d_isbn,int display);
	//by 준영, 네이버 도서 api 해당 auth 값 도서 검색 메소드_210228
	public List<BookDto> detailAjax(String d_auth,int display, String sort);
	//by 남기, 네이버 도서 api 해당 keyword 값 도서 검색 메소드_210303
	public List<BookDto> searchBookList(String keyword,int display, int start, HttpServletRequest request, ModelAndView mView);
	//by 남기, 네이버 도서 api 해당 d_isbn 값 도서 정보 가져오는 메소드_210303
	public List<BookDto> bookReview(String d_isbn, int display);
	//by 욱현, 메인화면 도서추천 메소드_2021324 
	public List<BookDto> recommendBook(String d_cont, int display, int start, String sort, ModelAndView mView);
	//by 욱현, 로그인된 아이디의 최근검색어가 없는경우 도서 추천_2021308
	public List<BookDto> recommendBook(int display,int start,String sort, String query, ModelAndView mView);
	//부킹서비스용
	public Map<String, Object> recommendBook(String d_cont,int display, int start);
	//by준익, 검색어 페이징_2021.03.09 
	public List<BookDto> conditionSearch(String keyword,int display, int start, HttpServletRequest request, ModelAndView mView);
	//by욱현.최근검색키워드를 recentsearch 칼럼에 담기위한 비즈니스로직_2021308
	public void recentSearchInput(String keyword, String id);
}