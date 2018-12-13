package com.ljn.mall.domain;

import java.sql.Timestamp;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 回复实体类
 * @author ljn
 * @date 2018年12月11日
 */
public class Reply {

	private Integer id;      	//回复id
	private String replyer;	 	//回复人
	@JsonFormat(locale="zh",timezone="GMT+8",pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp date;			//回复日期
	private String replyHeader;		//回复者头像
	private String content;		//回复内容
	private String replyfor;	//被回复的人
	private Integer commentId;	//回复评论的id
	private Integer replyId;	//回复回复的id
	private String pid;			//商品id
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	public String getReplyHeader() {
		return replyHeader;
	}
	public void setReplyHeader(String replyHeader) {
		this.replyHeader = replyHeader;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyfor() {
		return replyfor;
	}
	public void setReplyfor(String replyfor) {
		this.replyfor = replyfor;
	}
	public Integer getCommentId() {
		return commentId;
	}
	public void setCommentId(Integer commentId) {
		this.commentId = commentId;
	}
	public Integer getReplyId() {
		return replyId;
	}
	public void setReplyId(Integer replyId) {
		this.replyId = replyId;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	@Override
	public String toString() {
		return "Reply [id=" + id + ", replyer=" + replyer + ", date=" + date + ", replyHeader=" + replyHeader
				+ ", content=" + content + ", replyfor=" + replyfor + ", commentId=" + commentId + ", replyId="
				+ replyId + ", pid=" + pid + "]";
	}
	
	
	
	
}
