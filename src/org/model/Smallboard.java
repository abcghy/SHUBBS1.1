package org.model;

import java.util.HashSet;
import java.util.Set;

/**
 * Smallboard entity. @author MyEclipse Persistence Tools
 */

public class Smallboard implements java.io.Serializable {

	// Fields

	private Integer smBoidid;
	private Bigboard bigboard;
	private String smBoTitle;
	private Set postses = new HashSet(0);

	// Constructors

	/** default constructor */
	public Smallboard() {
	}

	/** minimal constructor */
	public Smallboard(Integer smBoidid) {
		this.smBoidid = smBoidid;
	}

	/** full constructor */
	public Smallboard(Integer smBoidid, Bigboard bigboard, String smBoTitle,
			Set postses) {
		this.smBoidid = smBoidid;
		this.bigboard = bigboard;
		this.smBoTitle = smBoTitle;
		this.postses = postses;
	}

	// Property accessors

	public Integer getSmBoidid() {
		return this.smBoidid;
	}

	public void setSmBoidid(Integer smBoidid) {
		this.smBoidid = smBoidid;
	}

	public Bigboard getBigboard() {
		return this.bigboard;
	}

	public void setBigboard(Bigboard bigboard) {
		this.bigboard = bigboard;
	}

	public String getSmBoTitle() {
		return this.smBoTitle;
	}

	public void setSmBoTitle(String smBoTitle) {
		this.smBoTitle = smBoTitle;
	}

	public Set getPostses() {
		return this.postses;
	}

	public void setPostses(Set postses) {
		this.postses = postses;
	}

}