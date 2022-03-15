package com.acorn5.booking.cart.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.acorn5.booking.cart.entity.Cart;

public interface CartService {
	public void insertCart(Cart dto, HttpServletRequest request);

	public void listCart(ModelAndView mView, HttpServletRequest request);

	public void deleteCart(Long id);

	public void update(Cart dto);

	public void deletPay(Long id, HttpServletRequest request);

	public List<Cart> getCart(Long id);
}
