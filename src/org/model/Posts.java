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
	private String content;
	private Integer goodcount;
	private Integer reply;
	private Integer essence;
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
			String title, Timestamp createtime, String content,
			Integer goodcount, Integer reply, Integer essence, Set replies) {
		this.postid = postid;
		this.userinfo = userinfo;
		this.smallboard = smallboard;
		this.title = title;
		this.createtime = createtime;
		this.content = content;
		this.goodcount = goodcount;
		this.reply = reply;
		this.essence = essence;
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

	public Integer getReply() {
		return this.reply;
	}

	public void setReply(Integer reply) {
		this.reply = reply;
	}

	public Integer getEssence() {
		return this.essence;
	}

	public void setEssence(Integer essence) {
		this.essence = essence;
	}

	public Set getReplies() {
		return this.replies;
	}

	public void setReplies(Set replies) {
		this.replies = replies;
	}

}