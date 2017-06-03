package com.ebook.list.servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ebook.entity.BookList;
import com.ebook.list.dao.ListDao;
import com.ebook.utils.ResultsetToList;
import com.ebook.utils.RsToJson;


@WebServlet("/GetCount")
public class GetCount extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String spid = request.getParameter("spid");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String Time="";
		
		if(spid !=null){
			spid="where b.i_spid ="+spid;	
		}
		else{
			spid=" ";
		}				
		if(startTime!=null)
		{			
			Time ="and"+ startTime+ "< cc_discu.s_create_time ";			
		}
		else if(endTime!=null)
		{			
			Time +="<"+ endTime;			
		}
		else{
			Time="";
		}
		
        /*设置字符集为'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 
        ResultSet rs = ListDao.getCount(spid,Time);
        String result;
		try {
			result = RsToJson.resultSetToJson(rs);
			PrintWriter out = response.getWriter();
			out.print(result);
		} catch (SQLException | JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		finally{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	      }
	}
}