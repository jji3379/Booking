package com.acorn5.booking.users.dto;

import java.util.List;

import org.springframework.data.domain.Page;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.entity.Users;

public class UserInfoDto {
	private Users user;
	private Page<Review> review;
	private Page<ReviewDtl> reviewDtl;
	private Page<Cart> cart;
	
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public Page<Review> getReview() {
		return review;
	}
	public void setReview(Page<Review> review) {
		this.review = review;
	}
	public Page<ReviewDtl> getReviewDtl() {
		return reviewDtl;
	}
	public void setReviewDtl(Page<ReviewDtl> reviewDtl) {
		this.reviewDtl = reviewDtl;
	}
	public Page<Cart> getCart() {
		return cart;
	}
	public void setCart(Page<Cart> cart) {
		this.cart = cart;
	}	
}
