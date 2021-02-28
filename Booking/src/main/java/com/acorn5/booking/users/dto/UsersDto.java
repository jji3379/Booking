package com.acorn5.booking.users.dto;

public class UsersDto {
	private int num;
	private String pwd;
	private String id;
	private String profile;
	private String regdate;
	private String recentSearch;
	private String care;
	private String email;
	private String newPwd; //새 비밀번호를 담을 필드
	
	public UsersDto() {}
	
	public UsersDto(int num, String pwd, String id, String profile, String regdate, String recentSearch, String care, String email) {
		super();
		this.num = num;
		this.pwd = pwd;
		this.id = id;
		this.profile = profile;
		this.regdate = regdate;
		this.recentSearch = recentSearch;
		this.care = care;
		this.email = email;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getRecentSearch() {
		return recentSearch;
	}

	public void setRecentSearch(String recentSearch) {
		this.recentSearch = recentSearch;
	}

	public String getCare() {
		return care;
	}

	public void setCare(String care) {
		this.care = care;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	
	
	

}