package com.acorn5.booking.review.entity;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.web.multipart.MultipartFile;

import com.acorn5.booking.users.entity.Users;

@Entity
@Table(name = "BK_BOOK_REVIEW_MST")
public class Review {
	
	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "REVIEW_ID")
	private Long id; // 리뷰 번호
	
	@ManyToOne
	@JoinColumn(name = "writer")
	private Users writer; // 리뷰 작성자
	private String imagePath; // 리뷰 이미지 경로
	private String bookTitle; // 책 제목
	private String reviewTitle; // 리뷰 제목
	private String content; // 리뷰 내용
	private int rating; // 별점
	private int viewCount; // 리뷰의 조회수
	private LocalDateTime regdate; // 작성일
	//private int startRowNum; // 시작 번호
	//private int endRowNum; // 마지막 번호
	private String isbn; // 책 고유번호
	//private MultipartFile image; // 이미지 파일
	private String spoCheck; //by채영_스포일러 포함 여부
	
	public Users getWriter() {
		return writer;
	}
	public void setWriter(Users writer) {
		this.writer = writer;
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public LocalDateTime getRegdate() {
		return regdate;
	}
	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}

	/*
	 * public int getStartRowNum() { return startRowNum; } public void
	 * setStartRowNum(int startRowNum) { this.startRowNum = startRowNum; } public
	 * int getEndRowNum() { return endRowNum; } public void setEndRowNum(int
	 * endRowNum) { this.endRowNum = endRowNum; }
	 */
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	/*
	 * public MultipartFile getImage() { return image; } public void
	 * setImage(MultipartFile image) { this.image = image; }
	 */
	public String getSpoCheck() {
		return spoCheck;
	}
	public void setSpoCheck(String spoCheck) {
		this.spoCheck = spoCheck;
	}
	
}
