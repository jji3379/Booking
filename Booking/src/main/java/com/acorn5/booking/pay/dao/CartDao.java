package com.acorn5.booking.pay.dao;

import java.util.List;

import com.acorn5.booking.pay.dto.CartDto;

public interface CartDao {
	
	//장바구니 담기
	public void insert(CartDto dto);
	//장바구니 목록
	public List<CartDto> getlist(String id);
	//장바구니 삭제
	public void delete(int c_id);
	//장바구니 체크 삭제
	public void chk_delete(String c_id);
	//특정책 수량변경
	public void update(CartDto dto);
	//결제완료시 삭제
	public void pay_delete(String id);
}
