package com.acorn5.booking.order.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;

public interface OrderService {
	
	public List<OrderDtl> orderInsert(List<OrderDtl> dto, HttpServletRequest request);

	public Page<Order> getMyOrder(Long id, HttpServletRequest request, Pageable pageable);

	public Page<Order> getMyTermOrder(Long id, HttpServletRequest request, Pageable pageable, Date startDate,
			Date endDate);

	public List<OrderDtl> getOrderDetail(Long orderId);
}
