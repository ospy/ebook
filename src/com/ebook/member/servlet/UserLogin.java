package com.ebook.member.servlet;

import java.awt.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.ebook.entity.Member;
import com.ebook.member.dao.LoginHistory;
import com.ebook.member.dao.MemberDao;
import com.ebook.account.dao.Account;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String username = request.getParameter("uName");
		String pwd  = request.getParameter("pwd");
		String ip  = request.getParameter("ip");
		String city  = request.getParameter("city");
		String url = request.getParameter("url");
		String md5pwd = DigestUtils.md5Hex(pwd);
		
		ArrayList<Member> result = MemberDao.userLogin(username, md5pwd);
		
		
	        if(result.get(0).getLoginid()!=null){
	        HttpSession session = request.getSession(); 
	        session.setAttribute("username", result.get(0).getLoginid()); 
	        session.setAttribute("uid", result.get(0).getUid()); 
	        session.setAttribute("email", result.get(0).getEmail());
	        session.setAttribute("level", result.get(0).getS_level());
	        session.setAttribute("state", result.get(0).getState());
	        String balance = Account.Balance(result.get(0).getUid());
	        session.setAttribute("account", balance); 
	        LoginHistory.loginin(result.get(0).getUid(),ip,city);
			PrintWriter out = response.getWriter();
			out.print(1);
		}
	        else{
	        	PrintWriter out = response.getWriter();
				out.print(0);
	        }
	
	}

}
