package com.acorn5.booking.book.dto;

public class BookDto {
	private String title; // 책제목
    private String link; // 문서의 링크
    private String image; // 썸네일 이미지의 URL
    private String author; // 책 저자
    private String price; // 정가
    private String discount; // 할인가
    private String publisher; // 출판사
    private String pubdate; // 출간일
    private String isbn; // 도서번호
    private String description; // 책 내용 요약 정보

    @Override
    public String toString() {
        return "Book [title=" + title + ", link=" + link + ", image=" + image + ", author=" + author + ", price=" + price
                + ", discount=" + discount + ", publisher=" + publisher + ", pubdate=" + pubdate + ", isbn=" + isbn
                + ", description=" + description + "]";
    }

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDiscount() {
		return discount;
	}

	public void setDiscount(String discount) {
		this.discount = discount;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPubdate() {
		return pubdate;
	}

	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
    
}