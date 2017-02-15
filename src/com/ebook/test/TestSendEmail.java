package com.ebook.test;

import javax.servlet.http.HttpServletRequest;

import org.junit.Test;
import org.junit.runner.Request;

import com.ebook.utils.SendEmailUtil;

public class TestSendEmail {

	public static void main(String[] args) {

	}
	
	@Test
	public void sendEmail(){
		SendEmailUtil.sendEmail("123@qq.com", HttpServletRequest Request);
	}

}
