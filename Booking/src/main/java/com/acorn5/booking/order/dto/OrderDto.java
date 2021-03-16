package com.acorn5.booking.order.dto;

import java.security.Timestamp;

public class OrderDto {
	private int o_id; //오더넘버
	private String buyer;//구매자
	private String image;//이미지
	private String title;//제목
	private int price; //정가
	private int d_price;//할인가
	private int count;//갯수
	private Timestamp o_date;//주문일
	
	public OrderDto() {}

	public OrderDto(int o_id, String buyer, String image, String title, int price, int d_price, int count,
			Timestamp o_date) {
		super();
		this.o_id = o_id;
		this.buyer = buyer;
		this.image = image;
		this.title = title;
		this.price = price;
		this.d_price = d_price;
		this.count = count;
		this.o_date = o_date;
	}

	public int getO_id() {
		return o_id;
	}

	public void setO_id(int o_id) {
		this.o_id = o_id;
	}

	public String getBuyer() {
		return buyer;
	}

	public void setBuyer(String buyer) {
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

	public Timestamp getO_date() {
		return o_date;
	}

	public void setO_date(Timestamp o_date) {
		this.o_date = o_date;
	}
	
}
