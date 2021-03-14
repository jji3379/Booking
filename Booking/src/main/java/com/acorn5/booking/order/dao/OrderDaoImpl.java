package com.acorn5.booking.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.order.dto.OrderDto;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	private SqlSession session;
	
	//by준영, 장바구니 담기(저장) 처리_210308
	@Override
	public void insertOrder(OrderDto dto) {
		session.insert("order.insert",dto);
	}
}
