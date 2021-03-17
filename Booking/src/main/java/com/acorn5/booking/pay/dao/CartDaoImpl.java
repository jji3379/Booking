package com.acorn5.booking.pay.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn5.booking.pay.dto.CartDto;


@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private SqlSession session;
	
	//by준영, 장바구니 담기(저장) 처리_210308
	@Override
	public void insert(CartDto dto) {
		session.insert("cart.insert",dto);
	}
	//by준영, 북카트 리스트_210308
	@Override
	public List<CartDto> getlist(String id) {
		List<CartDto> listCart=session.selectList("cart.getlist",id);
		return listCart;
	}
	//by, 카트 개별 삭제 요청처리_210310
	@Override
	public void delete(int c_id) {
		session.delete("cart.delete", c_id);
	}
	//by준영, 체크된 카트 삭제_210313
	@Override
	public void chk_delete(String c_id) {
		
		session.delete("cart.deleteChk",Integer.parseInt(c_id));
	}
	//by준영, 북카트 내 도서 수량변경_210310
	@Override
	public void update(CartDto dto) {
		session.update("cart.update", dto);
		
	}
	//by_준영, 결제완료시 해당상품 삭제_210314
	@Override
	public void pay_delete(String id) {
		session.delete("cart.deletePay",id);
		
	}
}
