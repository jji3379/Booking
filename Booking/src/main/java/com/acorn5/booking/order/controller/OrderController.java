package com.acorn5.booking.order.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.service.OrderService;


public class OrderController {
	@Autowired
	private OrderService service;
	
	//by준영, 장바구니 담기(저장) 처리_210308
	
	@RequestMapping(value = "/pay/order_insertform")
	public void insertCart(OrderDto dto,HttpServletRequest request) {
		/* service.insertCart(dto, request); */
	}
}
