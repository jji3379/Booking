package com.acorn5.booking.pay.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.dto.CartDto;
import com.acorn5.booking.pay.service.CartService;

@Controller
public class PayController {
	@Autowired
	private CartService service;

	// by준영, 장바구니 저장 처리_210308
	
	@RequestMapping(value = "/pay/middle")
	public void insertCart(CartDto dto,HttpServletRequest request) {
		service.insertCart(dto, request);
	}
	
	//by준영, 네비바경로 장바구니 처리_210308
	@RequestMapping("/pay/middle2")
	public String Cart(ModelAndView mView,HttpServletRequest request) {
		return "pay/middle2";
	}
	
	//by준영, 장바구니 리스트_210308
	@RequestMapping("/pay/cart")
	public ModelAndView listCart(ModelAndView mView, HttpServletRequest request){
		service.listCart(mView, request); 
		mView.setViewName("pay/cart");
		return mView;
	}	
	//by, 글 삭제 요청처리_210303
	@RequestMapping("/pay/delete")
	public String delete(int c_id) {
		service.deleteCart(c_id);
		return "pay/delete";
	}
	
	// 체크된 카트 삭제
	@ResponseBody
	@RequestMapping(value = "/pay/deleteCart")
	public void deleteCart(HttpServletRequest request) {
		String[] ajaxMsg=request.getParameterValues("valueArr");
		
		service.deleteChk(ajaxMsg);
		
	}
	
	@RequestMapping("/pay/update")
	public String update(CartDto dto) {
		service.update(dto);
		return "pay/update";
	}
	@RequestMapping("/pay/pay")
	public String pay(HttpServletRequest request) {
		return "pay/pay";
	}
	@RequestMapping("/pay/paid")
	public String deletePaid(HttpServletRequest request) {
		String id=request.getParameter("id");
		service.deletPay(id);
		return "pay/paid";
	}
}
