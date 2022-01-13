package com.acorn5.booking.users.dto;

import java.util.List;

import com.acorn5.booking.pay.entity.Cart;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.acorn5.booking.users.entity.Users;

public class UserInfoDto {
	private Users user;
	private List<Review> review;
	private List<ReviewDtl> reviewDtl;
	private List<Cart> cart;
	
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public List<Review> getReview() {
		return review;
	}
	public void setReview(List<Review> review) {
		this.review = review;
	}
	public List<ReviewDtl> getReviewDtl() {
		return reviewDtl;
	}
	public void setReviewDtl(List<ReviewDtl> reviewDtl) {
		this.reviewDtl = reviewDtl;
	}
	public List<Cart> getCart() {
		return cart;
	}
	public void setCart(List<Cart> cart) {
		this.cart = cart;
	}
		
}
