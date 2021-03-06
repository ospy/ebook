package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

import com.ebook.entity.MemberInfo;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;

/**
 * Servlet implementation class UpdatePsw
 */
@WebServlet("/UpdatePwd")
public class UpdatePwd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String oldpwd  = request.getParameter("oldpwd");
		String pwd  = request.getParameter("PWD");
		
		HttpSession session = request.getSession();
		String uid= (String)session.getAttribute("uid");
		PrintWriter out = response.getWriter();
		String result="";
if(uid!=null&&uid!=""){	
	    oldpwd=DigestUtils.md5Hex(oldpwd);	    
	    String sql = "select count(1) from cc_member where i_uid='"+uid+"' and s_password='"+oldpwd+"' and b_deleted=0";
		int count= DatabaseTools.getCount(sql);
		if(count>0){		
		 pwd=DigestUtils.md5Hex(pwd);
		 Connection conn = DBPool.getInstance().getConnection(); 
			String sql1 = "{call updatepwd(?,?)}";
			CallableStatement call1;
			try {
				call1 = conn.prepareCall(sql1);
				call1.setString(1,uid);
				call1.setString(2,pwd);
				call1.execute();
				call1.close();				
				 result="1";				
			    conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  }
		else{
			result="-1";
		};	 
	}
	 else{
		 result="0";   
		   }
     out.print(result);	
   }
	 
}