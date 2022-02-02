package com.acorn5.booking.order.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;

@Controller
public class OrderViewController {

	@Autowired
	private UsersRepository usersRepository;
	
	// 유저 주문정보 조회
	@RequestMapping("/user/{id}/order")
	public ModelAndView getOrder(@PathVariable Long id, ModelAndView mView, HttpServletRequest request) {
		Users dto = usersRepository.findById(id);

		mView.addObject("dto", dto);
		mView.setViewName("users/private/my_order.page");

		return mView;
	}

	// 주문 상세 페이지
	@RequestMapping("/user/{id}/order/{orderId}")
	public ModelAndView getOrderDetail(@PathVariable Long id, @PathVariable Long orderId, ModelAndView mView) {
		mView.addObject("orderId", orderId);
		mView.setViewName("users/private/order_detail.page");

		return mView;
	}
	
}