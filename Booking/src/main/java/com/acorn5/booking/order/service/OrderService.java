package com.acorn5.booking.order.service;

import javax.servlet.http.HttpServletRequest;

import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.pay.dto.CartDto;

public interface OrderService {
	
	//by준영, 장바구니 담기(저장) 처리_210308
	public void insertCart(OrderDto dto,HttpServletRequest request);
}
