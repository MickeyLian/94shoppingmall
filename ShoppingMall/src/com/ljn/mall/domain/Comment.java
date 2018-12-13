package com.ljn.mall.domain;

import java.sql.Timestamp;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 评论实体类
 * @author ljn
 * @date 2018年12月11日
 */
public class Comment {

	private Integer id;			//评论id
	private String commentor;	//评论者
	@JsonFormat(locale="zh",timezone="GMT+8",pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp date;			//评论日期
	private String commentHeader;	//评论者头像
	private String content;		//评论内容
	private String pid;			//商品id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCommentor() {
		return commentor;
	}
	public void setCommentor(String commentor) {
		this.commentor = commentor;
	}
	
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	public String getCommentHeader() {
		return commentHeader;
	}
	public void setCommentHeader(String commentHeader) {
		this.commentHeader = commentHeader;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	@Override
	public String toString() {
		return "Comment [id=" + id + ", commentor=" + commentor + ", date=" + date + ", commentHeader=" + commentHeader
				+ ", content=" + content + ", pid=" + pid + "]";
	}
	
	
	
}
