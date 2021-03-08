package com.acorn5.booking.review.dto;

import org.springframework.web.multipart.MultipartFile;

public class ReviewDto {
	// by남기 _210303
	private int num; // 리뷰 번호
	private String writer; // 리뷰 작성자
	private String imagePath; // 리뷰 이미지 경로
	private String reviewTitle; // 리뷰 제목
	private String content; // 리뷰 내용
	private int viewCount; // 리뷰의 조회수
	private String regdate; // 작성일
	private int startRowNum; // 시작 번호
	private int endRowNum; // 마지막 번호
	private String isbn; // 책 고유번호
	private MultipartFile image; // 이미지 파일
	//디폴트 생성자 
	public ReviewDto() {}
	
	public ReviewDto(int num, String writer, String imagePath, String reviewTitle, String content, int viewCount,
			String regdate, int startRowNum, int endRowNum, String isbn, MultipartFile image) {
		super();
		this.num = num;
		this.writer = writer;
		this.imagePath = imagePath;
		this.reviewTitle = reviewTitle;
		this.content = content;
		this.viewCount = viewCount;
		this.regdate = regdate;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.isbn = isbn;
		this.image = image;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public MultipartFile getImage() {
		return image;
	}

	public void setImage(MultipartFile image) {
		this.image = image;
	}
}