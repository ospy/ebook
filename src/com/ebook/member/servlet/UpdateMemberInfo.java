package com.ebook.member.servlet;



/**
 * Servlet implementation class UpdateMemberInfo
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.mail.Session;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ebook.constant.Constant;
import com.ebook.entity.Member;
import com.ebook.entity.MemberInfo;
import com.ebook.member.dao.MemberDao;
import com.ebook.utils.DBPool;
import com.ebook.utils.DateUtils;
import com.mchange.v2.cfg.PropertiesConfigSource.Parse;


@WebServlet("/UpdateMemberInfo")
public class UpdateMemberInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		MemberInfo memberInfo = new MemberInfo();
		String occupation  = request.getParameter("occupation");
		String username = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("address");
		String capacity = request.getParameter("capacity");
		String speciality = request.getParameter("speciality");
		String tt = request.getParameter("education");
		int education =Integer.parseInt(tt);
		String uid=request.getParameter("id");

			
			Connection conn = DBPool.getInstance().getConnection(); 
			  //修改下载文件信息
			  try {
			 
						String sql1 = "{call UpdateMemberInfo(?,?,?,?,?,?,?,?)}";
						CallableStatement call1= conn.prepareCall(sql1);
						//一次给存储过程传递参数，插入书目信息
						call1.setString(1,uid);
						call1.setString(2,occupation);
						call1.setString(3,username);
						call1.setString(4,mobile);
						call1.setString(5,address);
						call1.setString(6,capacity);
						call1.setString(7,speciality);
						call1.setInt(8,education);
						
						call1.execute();
						call1.close();
					    conn.close();
					 
			       
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		
		PrintWriter out = response.getWriter();
		out.print(true);
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
