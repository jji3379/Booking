package com.acorn5.booking.book.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.service.ReviewService;

@RestController
@RequestMapping("/v1")
public class BookApiController {
	@Autowired
    private BookService bookService; 

	@Autowired
	private ReviewService reviewService; 
	
	@Autowired
	private CartService cartservice;
	
    //by준영, bookList.jsp 에 cont, sort 를 인자로 리스트 검색하는 서비스_210222
    @RequestMapping("/bestSeller")
    public Page<BookDto> bestSeller(HttpServletRequest request, Pageable pageable){
    	Long id=(Long)request.getSession().getAttribute("id");
    	ModelAndView mView = new ModelAndView();
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
		// service.bestSeller("1", 10, 1, "count");
        return bookService.bestSeller("1", 50, 1, "count", pageable);
    }

    @RequestMapping("/bookReview/{isbn}")
    public Page<Review> bookReview(@PathVariable String isbn, Pageable pageable, HttpServletRequest request){
    	Long id=(Long)request.getSession().getAttribute("id");
    	ModelAndView mView = new ModelAndView();
		if (id != null) {
			// by 우석, view page 에서 cartitem 불러오기_210315
			cartservice.listCart(mView, request);
		}
    	//bookService.bestSeller("1", 50, 1, "count", pageable);
    	return reviewService.getBookReview(isbn, pageable);
    }
}
