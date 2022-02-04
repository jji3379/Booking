package com.acorn5.booking.order.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;

public interface OrderService {
	
	// by욱현, my_order에 테이블에 담기_210317
	public List<OrderDtl> orderInsert(List<OrderDtl> dto, HttpServletRequest request);

	// by욱현, my_order에서 구매자 주문내역 불러오기 로직 _2021317
	public Page<Order> getMyOrder(Long id, HttpServletRequest request, Pageable pageable);

	// by욱현, my_order에서 구매자 주문내역 불러오기 로직 _2021317
	public Page<Order> getMyTermOrder(Long id, HttpServletRequest request, Pageable pageable, Date startDate,
			Date endDate);

	// by욱현, order_detail에서 주문내역 디테일 불러오는 로직_2021320
	public List<OrderDtl> getOrderDetail(Long orderId);
}
