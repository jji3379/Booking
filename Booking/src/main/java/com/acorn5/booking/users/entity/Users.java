package com.acorn5.booking.users.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "BK_USER_MST")
public class Users {
	
	@Id @GeneratedValue(strategy = GenerationType.AUTO)
	private int num;
	private String id;
	private String pwd;
	private String email;
	private String profileImg;
	private LocalDateTime regdate;
	private String care;
	private String recentSearch;
	
	/*
	 * @ManyToOne(fetch = FetchType.LAZY)
	 * 
	 * @JoinColumn(name = "TEAM_id") private Team team;
	 */
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public LocalDateTime getRegdate() {
		return regdate;
	}
	public void setRegdate(LocalDateTime regdate) {
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
	/*
	 * public Team getTeam() { return team; } public void setTeam(Team team) {
	 * this.team = team; }
	 */
	
	
}
