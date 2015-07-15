package org.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Posts entity. @author MyEclipse Persistence Tools
 */

public class Posts implements java.io.Serializable {

	// Fields

	private Integer postid;
	private Userinfo userinfo;
	private Smallboard smallboard;
	private String title;
	private Timestamp createtime;
	private Timestamp updatetime;
	private String content;
	private Integer goodcount;
	private String reply;
	private String good;
	private Set replies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Posts() {
	}

	/** minimal constructor */
	public Posts(Integer postid) {
		this.postid = postid;
	}

	/** full constructor */
	public Posts(Integer postid, Userinfo userinfo, Smallboard smallboard,
			String title, Timestamp createtime, Timestamp updatetime,
			String content, Integer goodcount, String reply, String good,
			Set replies) {
		this.postid = postid;
		this.userinfo = userinfo;
		this.smallboard = smallboard;
		this.title = title;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.content = content;
		this.goodcount = goodcount;
		this.reply = reply;
		this.good = good;
		this.replies = replies;
	}

	// Property accessors

	public Integer getPostid() {
		return this.postid;
	}

	public void setPostid(Integer postid) {
		this.postid = postid;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public Smallboard getSmallboard() {
		return this.smallboard;
	}

	public void setSmallboard(Smallboard smallboard) {
		this.smallboard = smallboard;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Timestamp getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	public Timestamp getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Timestamp updatetime) {
		this.updatetime = updatetime;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getGoodcount() {
		return this.goodcount;
	}

	public void setGoodcount(Integer goodcount) {
		this.goodcount = goodcount;
	}

	public String getReply() {
		return this.reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

	public String getGood() {
		return this.good;
	}

	public void setGood(String good) {
		this.good = good;
	}

	public Set getReplies() {
		return this.replies;
	}

	public void setReplies(Set replies) {
		this.replies = replies;
	}

}