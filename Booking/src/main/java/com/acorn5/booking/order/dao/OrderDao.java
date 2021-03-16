package com.acorn5.booking.order.dao;

import com.acorn5.booking.order.dto.OrderDto;

public interface OrderDao {
	//by준영, 장바구니 담기(저장) 처리_210308
	public void insertOrder(OrderDto dto);
	
}
