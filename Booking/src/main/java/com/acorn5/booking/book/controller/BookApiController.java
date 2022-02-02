package com.acorn5.booking.book.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.book.dto.BookDto;
import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.service.ReviewService;

@RestController
@RequestMapping("/v1")
public class BookApiController {
	
	@Autowired
    private BookService bookService; 

	@Autowired
	private ReviewService reviewService; 
	
    @GetMapping("/bestSeller/{start}")
    public List<BookDto> getBestSeller(@PathVariable int start, HttpServletRequest request){

    	return bookService.bestSeller("1", 10, start, "count");
    }

    @GetMapping("/bookReview/{isbn}")
    public Page<Review> getBookReview(@PathVariable String isbn, Pageable pageable, HttpServletRequest request){

    	return reviewService.getBookReview(isbn, pageable);
    }
    
    @GetMapping("/book-search")
    public Page<BookDto> getSearchBook(String keyword, Pageable pageable, HttpServletRequest request){
    	
    	return bookService.conditionSearch(keyword, 10, pageable);
    }
}
