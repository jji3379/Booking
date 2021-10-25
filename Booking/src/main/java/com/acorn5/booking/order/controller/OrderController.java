package com.acorn5.booking.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.service.OrderService;
import com.acorn5.booking.users.dao.UsersDao;
import com.acorn5.booking.users.dto.UsersDto;

@Controller
public class OrderController {
	//@Autowired
	//private OrderService service;
	
	//@Autowired //by욱현. 주문내역 페이지 에서도 프로필이미지를 볼수있게 하기위해_2021317
	//UsersDao dao;
	
	//by욱현. 결제한 책들을 my_order 테이블에 저장하기_2021317
	@RequestMapping("/pay/order_insert.do")
	public void orderInsert(HttpServletRequest request, OrderDto dto) {
		service.orderInsert(dto, request);
	}
	
	//by욱현.내 주문 내역 조회_2021316
	@RequestMapping("/users/private/my_order.do")
	public ModelAndView myOrder(HttpSession session, ModelAndView mView,
		HttpServletRequest request) {
		//뷰페이지에서 프로필이미지 로드를 위한 로직 
		String id = (String) session.getAttribute("id");
		UsersDto dto = dao.getData(id);
		mView.addObject("dto", dto);
		
		//주문내역을 조회하기 위한 로직
		OrderDto orderDto = new OrderDto();
		service.getMyOrder(session, mView, orderDto, request);
		mView.setViewName("users/private/my_order");
		return mView;
	}
	
	//by욱현. 주문조회 디테일 페이지
	@RequestMapping("/users/private/order_detail.do")
	public ModelAndView orderDetail(HttpSession session, ModelAndView mView,
			HttpServletRequest request) {
		//뷰페이지에서 프로필이미지 로드를 위한 로직 
		String id = (String) session.getAttribute("id");
		UsersDto dto = dao.getData(id);
		mView.addObject("dto", dto);
		
		//주문내역을 조회하기 위한 로직
		OrderDto orderDto = new OrderDto();
		service.getOrderDetail(mView, request);
		mView.setViewName("users/private/order_detail");
		return mView;
	}
	
	
}
