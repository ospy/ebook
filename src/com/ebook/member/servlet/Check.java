package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ebook.member.LoginRegisterService;

@WebServlet(name = "check.do", urlPatterns = { "/check.do" })
public class Check extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		switch (type) {
		case "email":
			checkEmail(value,request,response);
			break;
		case "name":
			checkName(value,request,response);
			break;
		default:
			break;
		}
		
		
	}

	
	protected void checkEmail(String value,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		out.print(LoginRegisterService.checkEmail(value));
	}
	
	protected void checkName(String value,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out= response.getWriter();
		out.print(LoginRegisterService.checkUserName(value));
	}
}