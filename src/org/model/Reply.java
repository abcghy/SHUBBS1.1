package org.model;

import java.sql.Timestamp;

/**
 * Reply entity. @author MyEclipse Persistence Tools
 */

public class Reply implements java.io.Serializable {

	// Fields

	private Long replyId;
	private Userinfo userinfo;
	private Posts posts;
	private String replyContent;
	private Timestamp replyCreatetime;

	// Constructors

	/** default constructor */
	public Reply() {
	}

	/** minimal constructor */
	public Reply(Long replyId) {
		this.replyId = replyId;
	}

	/** full constructor */
	public Reply(Long replyId, Userinfo userinfo, Posts posts,
			String replyContent, Timestamp replyCreatetime) {
		this.replyId = replyId;
		this.userinfo = userinfo;
		this.posts = posts;
		this.replyContent = replyContent;
		this.replyCreatetime = replyCreatetime;
	}

	// Property accessors

	public Long getReplyId() {
		return this.replyId;
	}

	public void setReplyId(Long replyId) {
		this.replyId = replyId;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Posts getPosts() {
		return this.posts;
	}

	public void setPosts(Posts posts) {
		this.posts = posts;
	}

	public String getReplyContent() {
		return this.replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Timestamp getReplyCreatetime() {
		return this.replyCreatetime;
	}

	public void setReplyCreatetime(Timestamp replyCreatetime) {
		this.replyCreatetime = replyCreatetime;
	}

}