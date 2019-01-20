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
import javax.swing.text.StyledEditorKit.BoldAction;

import com.ebook.constant.Constant;
import com.ebook.entity.Member;
import com.ebook.entity.MemberInfo;
import com.ebook.member.LoginRegisterService;
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
		String occupation  = request.getParameter("occupation").trim();
		String username = request.getParameter("name").trim();
		String mobile = request.getParameter("mobile").trim();
		String address = request.getParameter("address").trim();
		String capacity = request.getParameter("capacity").trim();
		String speciality = request.getParameter("speciality").trim();
		String edu = request.getParameter("education");
		int education =Integer.parseInt(edu);
		
		HttpSession session = request.getSession();
		String uid= (String)session.getAttribute("uid");
		
		String result="";
if(uid!=null&&uid!=""){		
		Member member = MemberDao.findMemberByID(uid);
		boolean checkMemberInfoUid=LoginRegisterService.checkMemberInfoUid(uid);	
			Connection conn = DBPool.getInstance().getConnection(); 
			if(member.getState()==3&&checkMemberInfoUid==false){
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
					    result="1";
			       
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		if(member.getState()==2&&checkMemberInfoUid==true){
			memberInfo.setId(member.getUid());
			memberInfo.setAddress(address);
			memberInfo.setCapacity(capacity);
			memberInfo.setEducation(edu);
			//memberInfo.setMember(member);
			memberInfo.setMobile(mobile);
			memberInfo.setName(username);
			memberInfo.setSpeciality(speciality);
			memberInfo.setOccupation(occupation);
			memberInfo.setCreatetime(DateUtils.format(null));
			
			MemberDao.saveMemberInfo(memberInfo);
			String newaward = com.ebook.account.dao.Account.Proc_Account(member.getUid(),"system",2,"+", 10, "完整填写个人信息，奖励10下载点");	
			if(newaward.equals("succ")){
				result="2";
			}
		
		}
		PrintWriter out = response.getWriter();
		out.print(result);
		//request.getRequestDispatcher("index.jsp").forward(request, response);
	  }
	}
}
