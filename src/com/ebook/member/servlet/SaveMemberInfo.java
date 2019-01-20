package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ebook.constant.Constant;
import com.ebook.entity.Account;
import com.ebook.entity.Member;
import com.ebook.entity.MemberInfo;
import com.ebook.member.LoginRegisterService;
import com.ebook.member.dao.MemberDao;
import com.ebook.utils.DateUtils;


@WebServlet("/SaveMemberInfo")
public class SaveMemberInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		MemberInfo memberInfo = new MemberInfo();
		String occupation  = request.getParameter("ocu");
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String address = request.getParameter("unit");
		String capacity = request.getParameter("level");
		String speciality = request.getParameter("spe");
		String education = request.getParameter("edu");
		HttpSession session = request.getSession();
		Member member= (Member) session.getAttribute(Constant.SESSION_USER);
		PrintWriter out = response.getWriter();
		if(member.getUid()!=null){
		boolean checkMemberInfoUid=LoginRegisterService.checkMemberInfoUid(member.getUid());
			if(member.getUid()!=null&&checkMemberInfoUid==true){
				memberInfo.setId(member.getUid());
				memberInfo.setAddress(address);
				memberInfo.setCapacity(capacity);
				memberInfo.setEducation(education);
				//memberInfo.setMember(member);
				memberInfo.setMobile(mobile);
				memberInfo.setName(name);
				memberInfo.setSpeciality(speciality);
				memberInfo.setOccupation(occupation);
				memberInfo.setCreatetime(DateUtils.format(null));
				
				MemberDao.saveMemberInfo(memberInfo);
				//注册赠送10下载点，注册赠送类型为2
				com.ebook.account.dao.Account.Proc_Account(member.getUid(),"system",2,"+", 10, "完整填写个人信息，奖励10下载点");			
				out.print(true);
				
			}
			else{
				out.print(false);
			  }
		}
		else{
			out.print("会话过期");
		}
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}