package com.acorn5.booking.order.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import com.acorn5.booking.users.entity.Users;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "MY_ORDER_MST")
public class Order {
	
	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ORDER_ID")
	private Long id; //오더넘버
	
	@ManyToOne
	@JoinColumn(name = "BUYER_ID")
	private Users buyer;//구매자
	private String image;//이미지
	private String title;//제목
	private int price; //정가
	private int d_price;//할인가
	private int count;//갯수
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@CreationTimestamp
	private Date o_date;//주문일
	private int totalPrice; //총 주문금액
	private String isbn;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Users getBuyer() {
		return buyer;
	}
	public void setBuyer(Users buyer) {
		this.buyer = buyer;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getD_price() {
		return d_price;
	}
	public void setD_price(int d_price) {
		this.d_price = d_price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getO_date() {
		return o_date;
	}
	public void setO_date(Date o_date) {
		this.o_date = o_date;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	
}
