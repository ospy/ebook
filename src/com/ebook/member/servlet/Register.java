package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;

import com.ebook.constant.Constant;
import com.ebook.entity.Member;
import com.ebook.member.LoginRegisterService;
import com.ebook.member.dao.MemberDao;
import com.ebook.utils.LOG;
import com.ebook.utils.SendEmailUtil;

import freemarker.template.TemplateException;

@WebServlet(name = "Member/Register", urlPatterns = { "/Member/Register" })
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String Loginid = request.getParameter("Loginid");
		String eEmail = request.getParameter("Email");
		String Password = request.getParameter("Password");
		String md5pwd = DigestUtils.md5Hex(Password);
		String ip = request.getParameter("ip");
		String city = request.getParameter("city");
		boolean mailstate=false;
		if(Loginid != null && !Loginid.equals("") && Password != null && !Password.equals("")){
			boolean uniqueUser = LoginRegisterService.checkUserName(Loginid);
			//用户唯一性检查
			if(uniqueUser){
				boolean uniqueEmail =  LoginRegisterService.checkEmail(eEmail);
				//Email唯一性检查

				if(uniqueEmail){
					//预插入新用户，i_state=0,b_deleted=1
					Member member = LoginRegisterService.registerSave(Loginid, eEmail, md5pwd,ip,city);
					try {
						//发送邮件并获取发送是否成功状态true or false
						 mailstate=SendEmailUtil.sendEmail(eEmail, request);
					} catch (TemplateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					if(member!=null&&mailstate){
						//邮件发送成功后，将预插入状态更新为可用
						member.setState(1);
						member.setB_deleted(0);
						MemberDao.updateMember(member);
						LoginRegisterService.insertAccount(member);
						LOG.info(member.getLoginid()+"注册成功！");
						// 保存用户注册Session
						request.getSession().setAttribute(Constant.SESSION_USER, member);
//						request.getRequestDispatcher("actmail.jsp").forward(request, response);
//						response.sendRedirect("actmail.jsp"); 
//						return;
						out.print("1");
					}
					else if(mailstate==false){
						out.print("1.1");
					}
				}else {
					request.setAttribute("errorMsg", eEmail+"已被使用！");
					out.print("2");
					LOG.info(eEmail+"Email已被使用！");
				}
			}else {
				request.setAttribute("errorMsg", Loginid+"用户名已被使用！");
				out.print("3");
				LOG.info(Loginid+"用户名已被使用！");
			}
		}
		out.close();	
	}

}
