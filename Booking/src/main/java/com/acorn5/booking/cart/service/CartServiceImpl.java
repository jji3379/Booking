package com.acorn5.booking.cart.service;

import java.util.List;

import javax.jdo.annotations.Transactional;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.cart.repository.CartRepository;
import com.acorn5.booking.users.entity.Users;

@Service
public class CartServiceImpl implements CartService {
	
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
	}
	
	//by준영, 북카트 리스트_210308
	@Override
	public void listCart(ModelAndView mView, HttpServletRequest request) {
		Long id = (Long) request.getSession().getAttribute("id");
		Users userId = new Users();
		userId.setId(id);
		List<Cart> list = cartRepository.findByUserId(userId);
		int basketCount = list.size();
		if (id != null && basketCount != 0) {
			mView.addObject("count", basketCount);
		}
		mView.addObject("list", list);

	}
	
	// by, 카트 개별 삭제 요청처리_210310
	@Override
	public void deleteCart(Long id) {
		cartRepository.delete(id);
	}

	// by준영, 북카트 내 도서 수량변경_210310
	@Override
	@Transactional
	public void update(Cart dto) {
		Long id = dto.getId();
		if (id != null) {
			Cart cart = cartRepository.findById(id);
			cart.setCount(dto.getCount());
			cart.setRegdate(dto.getRegdate());
			cartRepository.save(cart);
		}
	}

	// by_준영, 결제완료시 해당상품 삭제_210314
	@Override
	public void deletPay(Long id, HttpServletRequest request) {
		Users user = new Users();
		user.setId(id);
		List<Cart> myCart = cartRepository.findByUserId(user);
		for (int i = 0; i < myCart.size(); i++) {
			cartRepository.delete(myCart.get(i).getId());
		}
	}

	@Override
	public List<Cart> getCart(Long id) {
		Users user = new Users();
		user.setId(id);

		return cartRepository.findByUserId(user);
	}
}
