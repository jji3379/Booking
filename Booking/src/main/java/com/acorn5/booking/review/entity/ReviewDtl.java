package com.acorn5.booking.review.entity;

import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.TableGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

import com.acorn5.booking.users.entity.Users;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@TableGenerator(name = "REVIEW_DTL_SEQ_GENERATOR", table = "REVIEW_DTL_SEQ", pkColumnValue = "REVIEW_DTL_SEQ", allocationSize = 1)
@Table(name = "BK_BOOK_REVIEW_DTL")
public class ReviewDtl {
	
	@Id @GeneratedValue(strategy = GenerationType.TABLE, generator = "REVIEW_DTL_SEQ_GENERATOR")
	@Column(name = "REVIEW_COMMENT_ID")
	private Long id; 
	
	@ManyToOne
	@JoinColumn(name = "writer")
	private Users writer; 
	private String content; 
	
	@ManyToOne
	@JoinColumn(name = "target_id")
	private Users target_id;
	
	@ManyToOne
	@JoinColumn(name = "ref_Group")
	private Review refGroup; 
	
	@Column(name = "comment_group")
	private Long commentGroup; 
	
	@Temporal(TemporalType.TIMESTAMP)
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@CreationTimestamp
	private Date regdate; 

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Users getWriter() {
		return writer;
	}

	public void setWriter(Users writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Users getTarget_id() {
		return target_id;
	}

	public void setTarget_id(Users target_id) {
		this.target_id = target_id;
	}

	public Long getCommentGroup() {
		return commentGroup;
	}

	public void setCommentGroup(Long commentGroup) {
		this.commentGroup = commentGroup;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Review getRefGroup() {
		return refGroup;
	}

	public void setRefGroup(Review refGroup) {
		this.refGroup = refGroup;
	}
	
}