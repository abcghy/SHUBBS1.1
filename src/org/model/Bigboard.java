package org.model;

import java.util.HashSet;
import java.util.Set;

/**
 * Bigboard entity. @author MyEclipse Persistence Tools
 */

public class Bigboard implements java.io.Serializable {

	// Fields

	private Integer biBoid;
	private Userinfo userinfo;
	private String biBoTitle;
	private Set smallboards = new HashSet(0);

	// Constructors

	/** default constructor */
	public Bigboard() {
	}

	/** minimal constructor */
	public Bigboard(Integer biBoid) {
		this.biBoid = biBoid;
	}

	/** full constructor */
	public Bigboard(Integer biBoid, Userinfo userinfo, String biBoTitle,
			Set smallboards) {
		this.biBoid = biBoid;
		this.userinfo = userinfo;
		this.biBoTitle = biBoTitle;
		this.smallboards = smallboards;
	}

	// Property accessors

	public Integer getBiBoid() {
		return this.biBoid;
	}

	public void setBiBoid(Integer biBoid) {
		this.biBoid = biBoid;
	}

	public Userinfo getUserinfo() {
		return this.userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public String getBiBoTitle() {
		return this.biBoTitle;
	}

	public void setBiBoTitle(String biBoTitle) {
		this.biBoTitle = biBoTitle;
	}

	public Set getSmallboards() {
		return this.smallboards;
	}

	public void setSmallboards(Set smallboards) {
		this.smallboards = smallboards;
	}

}