package com.acorn5.booking.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Provider;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.book.service.BookService;
import com.acorn5.booking.pay.service.CartService;
import com.acorn5.booking.review.dto.ReviewCommentDto;

import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.entity.QReviewDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.review.repository.ReviewCommentRepository;
import com.acorn5.booking.review.repository.ReviewRepository;
import com.acorn5.booking.review.service.ReviewService;
import com.acorn5.booking.users.entity.QUsers;
import com.querydsl.jpa.impl.JPAQueryFactory;

@Controller
public class ReviewViewController {
	
	@PersistenceContext
	EntityManager em;
	
	// by남기, 의존객체 DI 을 필드에 선언해둔다_210303
	@Autowired
    private BookService bookService;
	
	@Autowired
	private ReviewService service;

	@Autowired
	private ReviewRepository reviewRepository;
	
	@Autowired
	private ReviewCommentRepository reviewCommentRepository;
	
	// by남기, 글 목록 요청처리_210303
	@RequestMapping("/review")
	public String list(ModelAndView mView ,HttpServletRequest request) {

		return "review/reviewList.page"; 
	}
	
	// by남기, 글 상세정보 요청처리_210303  
	@RequestMapping(value = "/review/{id}")
	public String detail(@PathVariable Long id, Model model
			,HttpServletRequest request) {
		// by남기, 자세히 보여줄 글번호가 파라미터로 넘어온다_210303
		//Review review = service.getDetail(id);
		//String writer = review.getWriter().getLoginId();
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
				//reviewCommentRepository.findByRefGroup(id);

		// by남기, view page 로 forward 이동해서 응답_210303
		model.addAttribute("reviewId", id);
		model.addAttribute("reviewCommentList", reviewCommentList);
		model.addAttribute("dto", dto);
		//model.addAttribute("loginId", loginId);
		//model.addAttribute("writer", writer);
		//mView.setViewName("review/reviewDetail");
		return "review/reviewDetail.page";
	}
	

	// by남기, 새 리뷰 작성 폼 요청 처리_210303
	@RequestMapping("/private/reviewInsertform")
	public String insertform() {
		// by남기, view page 로 forward 이동해서 응답_210303
		return "review/private/reviewInsertform.page";

	}
	//by준영, 다이렉트 리뷰작성
    @RequestMapping("/review_directInsertform.do")
    public ModelAndView directReview(@RequestParam(required=false)String d_isbn){
    	ModelAndView mView = new ModelAndView();
        
        if(d_isbn !=null)
        {
            mView.addObject("reviewDirect",bookService.bookDetail(d_isbn,1));
        }
        mView.setViewName("detail/review_directInsertform.page");
        return mView;
    
    }
	// by남기, 리뷰 수정 폼 요청 처리_210303
	@RequestMapping("/private/review/update/{reviewId}")
	public ModelAndView updateform(@PathVariable Long reviewId,
			ModelAndView mView, HttpServletRequest request) {
		
		// by남기, view page 로 forward 이동해서 응답_210303
		mView.addObject("dto", service.getDetail(reviewId));
		mView.setViewName("review/private/reviewUpdateform.page");
		return mView;
	}
	
	// by남기, 리뷰 수정 요청 처리_210303
	@RequestMapping(value = "/reviewUpdate", method = RequestMethod.PUT)
	public String update(@PathVariable("id") Long id, @RequestBody Review review) {
		// by남기, 수정할 리뷰의 정보를 dto에서 가져온다_210303
		//service.updateContent(id, review);
		// by남기, view page 로 forward 이동해서 응답_210303
		return "review/private/reviewUpdate";
	}
	// by남기, 리뷰의 댓글 리스트 요청 처리_210303
	@RequestMapping("/reviewCommentList")
	public ModelAndView reviewCommentList(HttpServletRequest request,
			ModelAndView mView) {
		// by남기, 댓글 리스트를 request영역에서 가져온다_210303
		service.moreCommentList(request);
		// by남기, view page 로 forward 이동해서 응답_210303
		mView.setViewName("review/reviewCommentList");
		return mView;
	}

	// by남기, 댓글 수정 ajax 요청에 대한 요청 처리_210303
	@Transactional
	@RequestMapping(value = "/review/private/reviewComment_update", method=RequestMethod.POST)
	@ResponseBody
	public String reviewCommentUpdate(ReviewDtl dto){
		// by남기, 댓글을 수정 반영하고_210303
		service.updateComment(dto);
		// by남기, JSON 문자열을 클라이언트에게 응답한다_210303
		/*
		Map<String, Object> map=new HashMap<>();
		map.put("num", dto.getId());
		map.put("content", dto.getContent());
		*/
		return "redirect:/review/"+dto.getId();
	}
	
	// by남기, 리뷰의 댓글 삭제 요청 처리_210303
	@Transactional
	@RequestMapping("/review/private/reviewComment_delete")
	public ModelAndView reviewCommentDelete(HttpServletRequest request,
			ModelAndView mView, @RequestParam int refGroup) {
		// by남기, 삭제할 댓글의 정보를 request 영역에서 가져온다_210303
		//service.deleteComment(request);
		// by남기, reviewDetail page 로 리다일렉트 이동시킨다_210303
		mView.setViewName("redirect:/review/"+refGroup);
		return mView;
	}
	// by남기, 새 댓글 저장 요청 처리_210303
	@RequestMapping(value = "/review/private/reviewComment_insert", method = RequestMethod.POST)
	public String reviewCommentInsert(HttpServletRequest request, @RequestParam int refGroup) {
		// by남기, 새 댓글을 저장하고_210303
		service.saveComment(request);
		// by남기, 글 자세히 보기로 다시 리다일렉트 이동 시킨다_210303
		return "redirect:/review/"+refGroup;// by남기, ref_group 은 자세히 보기 했던 글번호_210303 
	}
	
}
