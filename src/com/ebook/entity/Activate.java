package com.ebook.entity;

public class Activate {
	
	private long id;
	private  Member member;
	private String code;
	private  String createTime;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
}
