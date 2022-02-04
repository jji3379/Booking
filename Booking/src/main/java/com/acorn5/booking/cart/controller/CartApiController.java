package com.acorn5.booking.cart.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.cart.service.CartService;

@RestController
@RequestMapping("/v1")
public class CartApiController {
	
	@Autowired
	private CartService cartService;
	   
	@PostMapping(value = "/user/{id}/cart")
	public void insertCart(Cart dto, HttpServletRequest request, @PathVariable Long id) {
		cartService.insertCart(dto,request);
	}
	
	@DeleteMapping("/user/{id}/cart/{cartId}")
	public void delete(@PathVariable Long id, @PathVariable Long cartId) {
		cartService.deleteCart(cartId);
	}
	
}
