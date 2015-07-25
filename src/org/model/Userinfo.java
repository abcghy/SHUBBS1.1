package org.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Userinfo entity. @author MyEclipse Persistence Tools
 */

public class Userinfo implements java.io.Serializable {

	// Fields

	private String admin;
	private String pwd;
	private String email;
	private String sex;
	private Date birthdate;
	private String phone;
	private String headpicurl;
	private Integer userlevel;
	private Timestamp registerdate;
	private Integer roleid;
	private Set postses = new HashSet(0);
	private Set replies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Userinfo() {
	}

	/** minimal constructor */
	public Userinfo(String admin, String pwd, String email, Integer userlevel,
			Timestamp registerdate) {
		this.admin = admin;
		this.pwd = pwd;
		this.email = email;
		this.userlevel = userlevel;
		this.registerdate = registerdate;
	}

	/** full constructor */
	public Userinfo(String admin, String pwd, String email, String sex,
			Date birthdate, String phone, String headpicurl, Integer userlevel,
			Timestamp registerdate, Integer roleid, Set postses, Set replies) {
		this.admin = admin;
		this.pwd = pwd;
		this.email = email;
		this.sex = sex;
		this.birthdate = birthdate;
		this.phone = phone;
		this.headpicurl = headpicurl;
		this.userlevel = userlevel;
		this.registerdate = registerdate;
		this.roleid = roleid;
		this.postses = postses;
		this.replies = replies;
	}

	// Property accessors

	public String getAdmin() {
		return this.admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Date getBirthdate() {
		return this.birthdate;
	}

	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHeadpicurl() {
		return this.headpicurl;
	}

	public void setHeadpicurl(String headpicurl) {
		this.headpicurl = headpicurl;
	}

	public Integer getUserlevel() {
		return this.userlevel;
	}

	public void setUserlevel(Integer userlevel) {
		this.userlevel = userlevel;
	}

	public Timestamp getRegisterdate() {
		return this.registerdate;
	}

	public void setRegisterdate(Timestamp registerdate) {
		this.registerdate = registerdate;
	}

	public Integer getRoleid() {
		return this.roleid;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}

	public Set getPostses() {
		return this.postses;
	}

	public void setPostses(Set postses) {
		this.postses = postses;
	}

	public Set getReplies() {
		return this.replies;
	}

	public void setReplies(Set replies) {
		this.replies = replies;
	}

}