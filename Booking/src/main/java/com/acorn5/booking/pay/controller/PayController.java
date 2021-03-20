package com.acorn5.booking.pay.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	   
	//by준영, 장바구니 담기(저장) 처리_210308
	
	@RequestMapping(value = "/pay/insert")
	public void insertCart(CartDto dto,HttpServletRequest request) {
		service.insertCart(dto,request);
	}
	
	//by준영, 북카트 리스트_210308
	@RequestMapping("/pay/cart")
	public ModelAndView listCart(ModelAndView mView, HttpServletRequest request){
		service.listCart(mView, request); 
		mView.setViewName("pay/cart");
		return mView;
	}	
	//by준영, 주문테이블 저장양식_210316
	@RequestMapping("/pay/order_insertform")
	public ModelAndView listCart2(ModelAndView mView, HttpServletRequest request){
		service.listCart(mView, request); 
		mView.setViewName("pay/order_insertform");
		return mView;
	}	
	//by, 카트 개별 삭제 요청처리_210310
	@RequestMapping("/pay/delete")
	public String delete(int c_id) {
		service.deleteCart(c_id);
		return "pay/delete";
	}
	
	//by준영, 체크된 카트 삭제_210313
	@ResponseBody
	@RequestMapping(value = "/pay/deleteCart")
	public void deleteCart(HttpServletRequest request) {
		String[] ajaxMsg=request.getParameterValues("valueArr");
		
		service.deleteChk(ajaxMsg);
		
	}
	//by준영, 북카트 내 도서 수량변경_210310
	@RequestMapping("/pay/update")
	public String update(CartDto dto) {
		service.update(dto);
		return "pay/update";
	}
	//by준영, 결제시 주소입력창_210318
	@RequestMapping("/pay/pay")
	public ModelAndView payItem(ModelAndView mView, HttpServletRequest request){
		service.listCart(mView, request); 
		mView.setViewName("pay/pay");
		return mView;
	}	
	
	
	//by준영, 결제완료 창_210314
	@RequestMapping("/pay/paid")
	public String deletePaid(HttpServletRequest request) {
		String id=(String)request.getSession().getAttribute("id");
		service.deletPay(id,request);
		return "pay/paid";
	}
}
