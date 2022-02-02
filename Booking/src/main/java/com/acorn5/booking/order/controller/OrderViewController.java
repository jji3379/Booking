package com.acorn5.booking.order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.service.CartService;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.order.service.OrderService;

@Controller
public class OrderViewController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartservice;

	//by욱현. 주문조회 디테일 페이지
	@RequestMapping("/users/private/myOrder/detail/{orderId}")
	public ModelAndView orderDetail(@PathVariable Long orderId ,HttpSession session, ModelAndView mView,
			HttpServletRequest request) {
		//뷰페이지에서 프로필이미지 로드를 위한 로직 
		//Users dto = usersRepository.findById(id);  
				//dao.getData(id);
		mView.addObject("orderId", orderId);
		mView.setViewName("users/private/order_detail.page");
		return mView;
	}
	
	
}