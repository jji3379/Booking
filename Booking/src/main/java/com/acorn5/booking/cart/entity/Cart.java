package com.acorn5.booking.cart.entity;

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
@Table(name = "MY_CART_MST")
public class Cart {

	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "CART_ID")
	private Long id;//장바구니 번호
	
	@ManyToOne
	@JoinColumn(name = "USER_ID")
	//@Column(name = "USER_ID")
    private Users userId;//회원 아이디
    private String image;//책 이미지
    private String title;//책 제목
    private int price;//책 정가
    private int d_price;//책 할인가
    private int count;// 갯수
    private String publisher;// 책 출판사
    private String author;//책 저자
    
    @Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@CreationTimestamp
    private Date regdate;
    private String isbn;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public Users getUserId() {
		return userId;
	}
	public void setUserId(Users userId) {
		this.userId = userId;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
    
}
