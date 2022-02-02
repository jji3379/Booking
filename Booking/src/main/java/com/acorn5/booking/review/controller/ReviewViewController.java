package com.acorn5.booking.review.controller;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;

import com.acorn5.booking.review.entity.QReviewDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.entity.QUsers;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Controller
public class ReviewViewController {
	
	@PersistenceContext
	EntityManager em;
	
	@Autowired
    private BookService bookService;
	
	@Autowired
	private ReviewService reviewService;

	@Autowired
	private ReviewRepository reviewRepository;
	
	// 전체 리뷰 조회
	@RequestMapping("/reviews") 
	public String getReviewList(ModelAndView mView ,HttpServletRequest request) {

		return "review/reviewList.page"; 
	}
	
	// 리뷰 디테일 조회
	@RequestMapping(value = "/review/{id}")
	public String getReviewDetail(@PathVariable Long id, Model model ,HttpServletRequest request) {

		Review dto=reviewRepository.findReviewDetail(id);
		reviewRepository.addViewCount(id);
		
		JPAQueryFactory query = new JPAQueryFactory(em);
		QReviewDtl qReviewDtl = QReviewDtl.reviewDtl;
		QUsers qUsers = QUsers.users;
		
		List<ReviewDtl> reviewCommentList = query.selectFrom(qReviewDtl)
				.join(qReviewDtl.writer, qUsers)
				.fetchJoin()
				.where(qReviewDtl.refGroup.eq(dto))
				.orderBy(qReviewDtl.commentGroup.asc())
				.fetch();

		model.addAttribute("reviewId", id);
		model.addAttribute("reviewCommentList", reviewCommentList);
		model.addAttribute("dto", dto);

		return "review/reviewDetail.page";
	}
	

	// 리뷰 작성 
	@RequestMapping("/new-review")
	public String insertReview() {

		return "review/private/reviewInsertform.page";
	}
	
	// 리뷰 바로 작성
    @RequestMapping("/new-review/{isbn}")
    public ModelAndView insertReviewDirect(@PathVariable String isbn){
    	ModelAndView mView = new ModelAndView();
        
        if(isbn !=null)
        {
            mView.addObject("reviewDirect",bookService.bookDetail(isbn,1));
        }
        mView.setViewName("detail/review_directInsertform.page");
        return mView;
    
    }
    
	// 리뷰 수정
	@RequestMapping("/review/{reviewId}/edit")
	public ModelAndView updateReview(@PathVariable Long reviewId,
			ModelAndView mView, HttpServletRequest request) {
		
		mView.addObject("dto", reviewService.getDetail(reviewId));
		mView.setViewName("review/private/reviewUpdateform.page");
		
		return mView;
	}

	// 댓글 등록 
	@PostMapping(value = "/v1/review/reply")
	public String insertReply(HttpServletRequest request, @RequestParam int refGroup) {
		reviewService.saveComment(request);
		
		return "redirect:/review/"+refGroup; 
	}
	
}
