package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

import org.apache.commons.codec.digest.DigestUtils;

import com.ebook.account.dao.Account;
import com.ebook.entity.Member;
import com.ebook.member.dao.LoginHistory;
import com.ebook.member.dao.MemberDao;

import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletContext;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet {
	    /**
	 * 用户和Session绑定关系
	 */
	public static final Map<String, HttpSession> USER_SESSION=new HashMap<String, HttpSession>();
	
	/**
	 * seeionId和用户的绑定关系
	 */
	public static final Map<String, String> SESSIONID_USER=new HashMap<String, String>();

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
		
		Member result = MemberDao.userLogin(username.trim(), md5pwd);
		PrintWriter out = response.getWriter();
	        if(result.getUid()!=null&&result.getState()>1){
	        HttpSession session = request.getSession(); 
	        ServletContext application=session.getServletContext();
            Map<String, String> loginMap = (Map<String, String>)application.getAttribute("loginMap");
	            if(loginMap==null){
	                loginMap = new HashMap<>();
	            }
	            for(String key:loginMap.keySet()) {
	                if (username.trim().equals(key)) {
	                    if(session.getId().equals(loginMap.get(key))) {
	                    	out.print(-1);//重复登录  
	                        return;
	                    }else{
	                    	out.print(-2);//异地已经登录	                      
	                        return;
	                    }
	                }
	            }
            loginMap.put(username.trim(),session.getId());
            application.setAttribute("loginMap", loginMap);
                        	        
	        session.setAttribute("username", result.getLoginid()); 
	        session.setAttribute("uid", result.getUid()); 
	        session.setAttribute("email", result.getEmail());
	        session.setAttribute("level", result.getS_level());
	        session.setAttribute("state", result.getState());
	        String balance = Account.Balance(result.getUid());
	        session.setAttribute("account", balance); 
	        out.print(1);
			System.out.println("登录成功！");
	        //session.setAttribute(Constant.SESSION_USER,result);
	        LoginHistory.loginin(result.getLoginid(),ip,city);				
		}
	        else if(result.getState()==1){
	        	out.print(-3);//未激活邮箱
	        }
	        else{	        	
				out.print(0);
	        }
	
	}
	
}
