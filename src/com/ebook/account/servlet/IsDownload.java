package com.ebook.account.servlet;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import com.ebook.account.dao.Account;
import com.ebook.detail.dao.DetailDao;
import com.ebook.entity.FileInfo;


/**
 * Servlet implementation class Detail
 */
@WebServlet("/IsDownload")
public class IsDownload extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("Uid");
		String bookid = request.getParameter("BookId");
		 /*设置字符集为'UTF-8'*/
        response.setCharacterEncoding("UTF-8"); 

			 String  downloadcount =Account.IsDownload(uid, bookid); 
			 String result="";
			 PrintWriter out = response.getWriter();
			 try {
				
				 if(!downloadcount.equals("0")){
					 result = DetailDao.getDownload(bookid);					 
					 }
				 else{
					 result="0";	 
				 }
				}
			
			 catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		out.print(result);	 
	}

}