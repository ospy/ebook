package com.ebook.list.servlet;


import java.util.List;
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

import com.ebook.utils.RsToJson; 

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
		String search=  request.getParameter("search");
		String spid = request.getParameter("spid");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String Time="";
		String condition="";
		
		if(search!=""){
		String [] searchArray = search.split("\\s+");
		for(String ss : searchArray){
		  condition +="and s_desc like \"%"+ss+"%\" ";
		  }
		}
		
		
		if(spid.equals("0")){
			spid=" ";	
		}
		else if(spid.equals("1")){
			spid="where b.i_spid <= 5700";	
		}
		else if(spid.equals("2")){
			spid="where  b.i_spid <=7600 and i_spid >=6000";	
		}
		else if(spid.equals("3")){
			spid="where  b.i_spid <=9100 and i_spid >=9000";	
		}
		else if(spid==""){
			spid=" ";
		}
		else{
			spid="where b.i_spid="+spid;	
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
       String rs0 = ListDao.getCount(condition,spid,Time);

			try {
			
				PrintWriter out = response.getWriter();
				out.print(rs0);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}


	}
}