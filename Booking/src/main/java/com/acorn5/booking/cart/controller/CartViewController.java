package com.acorn5.booking.cart.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.cart.service.CartService;

@Controller
public class CartViewController {
	
	@Autowired
	private CartService cartService;
	
	@RequestMapping("/user/{id}/cart")
	public ModelAndView listCart(ModelAndView mView, HttpServletRequest request, @PathVariable Long id){
		cartService.listCart(mView, request); 
		
		mView.setViewName("pay/cart.page");
		return mView;
	}
	
	//by준영, 북카트 내 도서 수량변경_210310
	@RequestMapping("/pay/update")
	public String update(Cart dto) {
		cartService.update(dto);
		
		return "pay/update";
	}
	//by준영, 결제시 주소입력창_210318
	@RequestMapping("/user/{id}/pay")
	public ModelAndView payItem(ModelAndView mView, HttpServletRequest request){
		cartService.listCart(mView, request); 
		mView.setViewName("pay/pay.page");
		
		return mView;
	}	
	
	//by준영, 결제완료 창_210314
	@RequestMapping("/pay/order/paid")
	public String deletePaid(HttpServletRequest request) {

		return "pay/paid.page";
	}
}
