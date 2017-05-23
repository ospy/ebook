package com.ebook.list.servlet;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ebook.entity.BookList;
import com.ebook.list.dao.ListDao;


@WebServlet("/ClassList")
public class ClassList extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String discuID = request.getParameter("discuID");
		BookList result = ListDao.getBookList(discuID);
		
	PrintWriter out = response.getWriter();
	out.print(result);
	}

}
