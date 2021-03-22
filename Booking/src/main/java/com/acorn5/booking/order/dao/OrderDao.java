package com.acorn5.booking.order.dao;

import java.util.List;

import com.acorn5.booking.order.dto.OrderDto;

public interface OrderDao {
	//by욱현. my_order 테이블에 저장_2021317
	public void insertOrder(OrderDto dto);
	
	//by욱현. 개인 주문내역 불러오기_2021317
	public List<OrderDto> getMyOrder(String buyer);
	
	//by욱현. 주문번호별로 책 불러오기_2021318
	public List<OrderDto> getMyOrder2(int o_id);
	
	//by욱현. 주문내역 row hover시 보여지는 상세내역_2021319
	public List<OrderDto> getOrderDetail(int o_id);
	
	//by욱현.회원탈퇴시 회원의 주문내역 삭제위해_21323
	public void delete(String buyer);
 	
}
