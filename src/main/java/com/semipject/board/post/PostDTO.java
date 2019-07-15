package com.semipject.board.post;

import org.json.simple.JSONArray;

public class PostDTO {
	private int postno;//"POSTNO" NUMBER NOT NULL ENABLE, 
	private String category;//"CATEGORY" VARCHAR2(30) NOT NULL ENABLE, 
	private String title;//"TITLE" VARCHAR2(100) NOT NULL ENABLE, 
	private String content;//"CONTENT" VARCHAR2(600) NOT NULL ENABLE, 
	private String userid;//"USERID" VARCHAR2(50) NOT NULL ENABLE, 
	private String regdate;//"REGDATE" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	private int views;//"VIEWS" NUMBER DEFAULT 0, 
	private String file_names;//"FILE_NAMES" VARCHAR2(1000), 
	private String deleted;//"DELETED" VARCHAR2(1) DEFAULT 0 NOT NULL ENABLE, 
	
	public PostDTO() {}

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}


	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getFile_names() {
		return file_names;
	}

	public void setFile_names(String file_names) {
		this.file_names = file_names;
	}


}
