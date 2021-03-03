package com.acorn5.booking.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.review.dto.ReviewCommentDto;
import com.acorn5.booking.review.dto.ReviewDto;
import com.acorn5.booking.review.service.ReviewService;

@Controller
public class ReviewController {
	// by남기._2021224
	
	//의존객체 DI 을 필드에 선언해둔다.
	@Autowired
	private ReviewService service;

	//글 목록 요청처리
	@RequestMapping("/review/list")
	public ModelAndView list(ModelAndView mView, 
			HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("review/list");
		return mView;
	}
	
	@RequestMapping("/review/detail")
	public ModelAndView detail(@RequestParam int num, ModelAndView mView) {
		//자세히 보여줄 글번호가 파라미터로 넘어온다.
		service.getDetail(num, mView);
		//view page 로 forward 이동해서 응답
		mView.setViewName("review/detail");
		return mView;
	}
	
	@RequestMapping("/review/private/delete")
	public String delete(@RequestParam int num) {
		service.deleteContent(num);
		return "review/private/delete";
	}
	
	//새 리뷰 글쓰기 요청 처리
	@RequestMapping("/review/private/insertform")
	public String insertform() {
		// /WEB-INF/views/    Review/private/insertform      .jsp 
		return "review/private/insertform";
	}
	
	@RequestMapping(value = "/review/private/insert", method = RequestMethod.POST)
	public String insert(ReviewDto dto, HttpServletRequest request) {
		service.saveContent(dto, request);
		return "redirect:/review/list.do";
	}
	
	@RequestMapping("/review/private/updateform")
	public ModelAndView updateform(@RequestParam int num,
			ModelAndView mView) {
		service.getDetail(num, mView);
		mView.setViewName("review/private/updateform");
		return mView;
	}
	
	@RequestMapping("/review/private/update")
	public String update(@ModelAttribute("dto") ReviewDto dto) {
		service.updateContent(dto);
		return "review/private/update";
	}
	
	@RequestMapping("/review/commentList")
	public ModelAndView commentList(HttpServletRequest request,
			ModelAndView mView) {
		service.moreCommentList(request);
		mView.setViewName("review/commentList");
		return mView;
	}

	//댓글 수정 ajax 요청에 대한 요청 처리 
	@RequestMapping(value = "/review/private/comment_update", 
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentUpdate(ReviewCommentDto dto){
		//댓글을 수정 반영하고 
		service.updateComment(dto);
		//JSON 문자열을 클라이언트에게 응답한다.
		Map<String, Object> map=new HashMap<>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
	}
	
	@RequestMapping("/review/private/comment_delete")
	public ModelAndView commentDelete(HttpServletRequest request,
			ModelAndView mView, @RequestParam int ref_group) {
		service.deleteComment(request);
		mView.setViewName("redirect:/review/detail.do?num="+ref_group);
		return mView;
	}
	//새 댓글 저장 요청 처리
	@RequestMapping(value = "/review/private/comment_insert", 
			method = RequestMethod.POST)
	public String commentInsert(HttpServletRequest request,
			@RequestParam int ref_group) {
		//새 댓글을 저장하고
		service.saveComment(request);
		//글 자세히 보기로 다시 리다일렉트 이동 시킨다.
		//ref_group 은 자세히 보기 했던 글번호 
		return "redirect:/review/detail.do?num="+ref_group;
	}
	
}
