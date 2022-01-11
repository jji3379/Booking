package com.acorn5.booking.order.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.order.dto.OrderDto;
import com.acorn5.booking.order.dto.OrderSum;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.pay.dto.CartDto;

public interface OrderService {
	
	//by욱현, my_order에 테이블에 담기_210317
	public Order orderInsert(Order dto, HttpServletRequest request);
	
	//by욱현, my_order에서 구매자 주문내역 불러오기 로직 _2021317
	public List<Order> getMyOrder(Long id, HttpServletRequest request);
	
	//by욱현, order_detail에서 주문내역 디테일 불러오는 로직_2021320
	public List<Order> getOrderDetail(Long id, HttpServletRequest request);
}
