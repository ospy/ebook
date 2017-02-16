package com.ebook.member.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.member.dao.MemberDao;
import com.ebook.utils.LOG;
import com.ebook.utils.Md5Util;


@WebServlet(name = "activateAccount", urlPatterns = { "/activateAccount" })
public class ActivateAccount extends HttpServlet {
	private static final String CHECK_CODE = "checkCode";
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String checkCode1  = request.getParameter(CHECK_CODE);
		String uid = request.getParameter("activationid");
		Member member = MemberDao.findMemberByID(uid);
		Activate activate = MemberDao.findActiveByUid(uid);
		String checkCode2 = Md5Util.execute(member.getUid() + ":"+ activate.getCode());
		if(checkCode1.equals(checkCode2)){
			//激活成功
			LOG.info("激活成功！");
			request.getRequestDispatcher("userinfo.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
