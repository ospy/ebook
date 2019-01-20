package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.xml.serializer.utils.Utils;

import com.ebook.utils.SendPsd;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;

import freemarker.template.TemplateException;

/**
 * Servlet implementation class FindPsd
 */
@WebServlet("/FindPsd")
public class FindPsd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindPsd() {
        super();
        // TODO Auto-generated constructor stub
    }

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
		String Loginid = request.getParameter("Loginid").trim();
		String eEmail = request.getParameter("Email").trim();
		String IP = request.getParameter("ip").trim();
		String city = request.getParameter("city").trim();
		PrintWriter out = response.getWriter();
		String result="";
		if(Loginid != null && !Loginid.equals("") && eEmail != null && !eEmail.equals("")){
		
			String sql = "select count(1) from cc_member where s_loginid='"+Loginid+"' and s_mail='"+eEmail+"' and b_deleted=0";
			int count= DatabaseTools.getCount(sql);		
			String sql2 = "SELECT count(1) FROM cc_findpsw  where s_loginid='"+Loginid+"' and DATE_SUB(CURDATE(), INTERVAL 30 DAY) <= date(s_create_time)";
			int currMonthTime= DatabaseTools.getCount(sql2);
			
			if (count > 0) {
				if(currMonthTime<4){
					//30天内只能修改密码3次
					try {
						result = SendPsd.sendEmail(eEmail,Loginid,IP,city);
					} catch (TemplateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				else{
					result = "-1.1";
				};
				
		    }
			else{
				result = "-1";
			};
		
		}
		 out.print(result);	
	}

}
