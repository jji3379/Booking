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
	
	@Override
	public void deleteCart(Long id) {
		cartRepository.delete(id);
	}

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
