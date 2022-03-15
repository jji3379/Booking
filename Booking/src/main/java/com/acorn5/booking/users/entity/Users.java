package com.acorn5.booking.users.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import com.acorn5.booking.cart.entity.Cart;
import com.acorn5.booking.order.entity.Order;
import com.acorn5.booking.order.entity.OrderDtl;
import com.acorn5.booking.review.entity.Review;
import com.acorn5.booking.review.entity.ReviewDtl;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "BK_USER_MST")
public class Users {
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "USER_ID")
	private Long id;
	private String loginId;
	private String pwd;
	private String email;
	private String profile;
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@CreationTimestamp
	private Date regdate;
	private String care;
	private String recentSearch;

	@OneToMany(mappedBy = "writer", cascade = CascadeType.REMOVE)
	private List<Review> review = new ArrayList<Review>();

	@OneToMany(mappedBy = "writer", cascade = CascadeType.REMOVE)
	private List<ReviewDtl> reviewDtl = new ArrayList<ReviewDtl>();
	
	@OneToMany(mappedBy = "target_id", cascade = CascadeType.REMOVE)
	private List<ReviewDtl> targetId = new ArrayList<ReviewDtl>();
	
	@OneToMany(mappedBy = "userId", cascade = CascadeType.REMOVE)
	private List<Cart> cart = new ArrayList<Cart>();
	
	@OneToMany(mappedBy = "buyer", cascade = CascadeType.REMOVE)
	private List<Order> order = new ArrayList<Order>();
	
	@OneToMany(mappedBy = "userId", cascade = CascadeType.REMOVE)
	private List<Search> search = new ArrayList<Search>();
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getCare() {
		return care;
	}
	public void setCare(String care) {
		this.care = care;
	}
	public String getRecentSearch() {
		return recentSearch;
	}
	public void setRecentSearch(String recentSearch) {
		this.recentSearch = recentSearch;
	}
	
}
