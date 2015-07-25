package org.model;

import java.util.HashSet;
import java.util.Set;

/**
 * Bigboard entity. @author MyEclipse Persistence Tools
 */

public class Bigboard implements java.io.Serializable {

	// Fields

	private Integer biBoid;
	private String biBoTitle;
	private String brief;
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
	public Bigboard(Integer biBoid, String biBoTitle, String brief,
			Set smallboards) {
		this.biBoid = biBoid;
		this.biBoTitle = biBoTitle;
		this.brief = brief;
		this.smallboards = smallboards;
	}

	// Property accessors

	public Integer getBiBoid() {
		return this.biBoid;
	}

	public void setBiBoid(Integer biBoid) {
		this.biBoid = biBoid;
	}

	public String getBiBoTitle() {
		return this.biBoTitle;
	}

	public void setBiBoTitle(String biBoTitle) {
		this.biBoTitle = biBoTitle;
	}

	public String getBrief() {
		return this.brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	public Set getSmallboards() {
		return this.smallboards;
	}

	public void setSmallboards(Set smallboards) {
		this.smallboards = smallboards;
	}

}