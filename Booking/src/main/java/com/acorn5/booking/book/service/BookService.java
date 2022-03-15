package com.acorn5.booking.book.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;

@Service
public interface BookService {
	
	public List<BookDto> pagingCategory(String d_cont, int display, int start, String d_catg,
			HttpServletRequest request, ModelAndView mView, String sort);

	public List<BookDto> bestSeller(String d_cont, int display, int start, String sort);

	public List<BookDto> bookDetail(String d_isbn, int display);

	public List<BookDto> detailAjax(String d_auth, int display, String sort);

	public List<BookDto> searchBookList(String keyword, int display, int start, HttpServletRequest request,
			ModelAndView mView);

	public List<BookDto> bookReview(String d_isbn, int display);

	public List<BookDto> careRecommendBook(String d_catg, int display, int start, String sort, ModelAndView mView);

	public List<BookDto> searchRecommendBook(int display, int start, String sort, String query, ModelAndView mView);

	public List<BookDto> bookingRecommendBook(String d_catg, int display, int start, String sort, ModelAndView mView);

	public Page<BookDto> conditionSearch(String keyword, int display, Pageable pageable);

	public void recentSearchInput(String keyword, Long id);
}