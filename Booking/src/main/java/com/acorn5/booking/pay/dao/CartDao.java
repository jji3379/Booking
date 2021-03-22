package com.acorn5.booking.pay.dao;

import java.util.List;

import com.acorn5.booking.pay.dto.CartDto;

public interface CartDao {
	
	//by준영, 장바구니 담기(저장) 처리_210308
	public void insert(CartDto dto);
	//by준영, 북카트 리스트_210308
	public List<CartDto> getlist(String id);
	//by, 카트 개별 삭제 요청처리_210310
	public void delete(int c_id);
	//by준영, 체크된 카트 삭제_210313
	public void chk_delete(String c_id);
	//by준영, 북카트 내 도서 수량변경_210310
	public void update(CartDto dto);
	//by_준영, 결제완료시 해당상품 삭제_210314
	public void pay_delete(String id);
	//by욱현. 회원탈퇴시 장바구니 목록 삭제_210323
	public void delete2(String id);
}
