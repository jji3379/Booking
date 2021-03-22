package com.acorn5.booking.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.order.dto.OrderDto;

@Repository
public class OrderDaoImpl implements OrderDao {
	
	@Autowired
	private SqlSession session;
	
	//by욱현. my_order 테이블에 저장_2021317
	@Override
	public void insertOrder(OrderDto dto) {
		session.insert("order.insert",dto);
	}
	
	//by욱현. 개인 주문내역 불러오기_2021317
	@Override
	public List<OrderDto> getMyOrder(String buyer) {
		List<OrderDto> list = session.selectList("order.getList", buyer);
		return list;
	}

	//by욱현. 주문번호별로 책 불러오기_2021318
	@Override
	public List<OrderDto> getMyOrder2(int o_id) {
		List<OrderDto> list = session.selectList("order.getList2", o_id);
		return list;
	}

	//by욱현. 주문내역 row hover시 보여지는 상세내역_2021319
	@Override
	public List<OrderDto> getOrderDetail(int o_id) {
		List<OrderDto> list = session.selectList("order.getDetailList", o_id);
		return list;
	}

	//by욱현.회원탈퇴시 회원의 주문내역 삭제위해_21323
	@Override
	public void delete(String buyer) {
		session.delete("order.delete", buyer);
		
	}
}
