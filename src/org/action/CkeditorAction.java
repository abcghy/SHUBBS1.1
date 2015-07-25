package org.action;

import com.opensymphony.xwork2.ActionSupport;

public class CkeditorAction extends ActionSupport{
	private String editor01;

	public String getEditor01() {
		return editor01;
	}

	public void setEditor01(String editor01) {
		this.editor01 = editor01;
	}

	@Override
	public String execute() throws Exception {
		System.out.println(getEditor01());
		return SUCCESS;
	}
	
}
