package com.acorn5.booking.pay.dto;



public class CartDto {
    private int c_id;//장바구니 번호
    private String id;//회원 아이디
    private String image;//책 이미지
    private String title;//책 제목
    private int price;//책 정가
    private int d_price;//책 할인가
    private int count;// 갯수
    private String indate;
    private String isbn;
    
    public CartDto() {}
    
    
	public CartDto(int c_id, String id, String image, String title, int price, int d_price, int count,
			String indate) {
		super();
		this.c_id = c_id;
		this.id = id;
		this.image = image;
		this.title = title;
		this.price = price;
		this.d_price = d_price;
		this.count = count;
		this.indate = indate;
	}


	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
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

	public String getIndate() {
		return indate;
	}

	public void setIndate(String indate) {
		this.indate = indate;
	}


	public String getIsbn() {
		return isbn;
	}


	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	

    
}