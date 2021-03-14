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
	
	@Override
	public void insert(CartDto dto) {
		session.insert("cart.insert",dto);
	}

	@Override
	public List<CartDto> getlist(String id) {
		List<CartDto> listCart=session.selectList("cart.getlist",id);
		return listCart;
	}

	@Override
	public void delete(int c_id) {
		session.delete("cart.delete", c_id);
	}
	
	@Override
	public void chk_delete(String c_id) {
		
		session.delete("cart.deleteChk",Integer.parseInt(c_id));
	}
	
	@Override
	public void update(CartDto dto) {
		session.update("cart.update", dto);
		
	}

	@Override
	public void pay_delete(String id) {
		session.delete("cart.deletePay",id);
		
	}


	

}
