package com.acorn5.booking.pay.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.jdo.annotations.Transactional;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.pay.dao.CartDao;
import com.acorn5.booking.pay.dto.CartDto;
import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.pay.repository.CartRepository;
import com.acorn5.booking.users.entity.Users;
import com.acorn5.booking.users.repository.UsersRepository;

@Service
public class CartServiceImpl implements CartService {
	//@Autowired
	//private CartDao cartDao;
	//by준영, 장바구니 담기(저장) 처리_210308
	
	@Autowired
	CartRepository cartRepository;
	
	@Override
	public void insertCart(Cart dto, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		if (id != null) {
			Users userId = new Users();
			userId.setId(id);
			dto.setUserId(userId);
			cartRepository.save(dto);
		}
		//cartDao.insert(dto);	
	}
	//by준영, 북카트 리스트_210308
	@Override
	public void listCart(ModelAndView mView, HttpServletRequest request) {
		Long id=(Long)request.getSession().getAttribute("id");
		Users userId = new Users();
		userId.setId(id);
		List<Cart> list = cartRepository.findByUserId(userId);
		int basketCount = list.size();
		if (id != null && basketCount != 0) {
			mView.addObject("count", basketCount);
		}
		mView.addObject("list", list);
		
	}
	//by, 카트 개별 삭제 요청처리_210310
	@Override
	public void deleteCart(Cart c_id) {
		cartRepository.delete(c_id);
	}
	//by준영, 체크된 카트 삭제_210313
	@Override
	public void deleteChk(Long ajaxMsg) {
		/*
		 * for(int i = 0; i < c_id.length; i++) { //cartDao.chk_delete(c_id[i]); }
		 */
		cartRepository.delete(ajaxMsg);
	}
	//by준영, 북카트 내 도서 수량변경_210310
	@Override
	@Transactional
	public void update(Cart dto) {
		Long id = dto.getId();
		if (id != null) {
			Cart cart = cartRepository.findById(id);
			cart.setCount(dto.getCount());
			cart.setIndate(dto.getIndate());
			cartRepository.save(cart);
		}
	}
	
	
	//by_준영, 결제완료시 해당상품 삭제_210314
	@Override
	public void deletPay(Long id,HttpServletRequest request) {
		cartRepository.delete(id); 
	}
}
