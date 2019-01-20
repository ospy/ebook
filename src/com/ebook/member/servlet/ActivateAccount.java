package com.ebook.member.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ebook.constant.Constant;
import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.member.dao.MemberDao;
import com.ebook.utils.DateUtils;
import com.ebook.utils.LOG;
import com.ebook.utils.Md5Util;


@WebServlet(name = "activateAccount", urlPatterns = { "/activateAccount" })
public class ActivateAccount extends HttpServlet {
	private static final String CHECK_CODE = "checkCode";
	private static final long serialVersionUID = 1L;

	//邮箱激活验证
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String checkCode1  = request.getParameter(CHECK_CODE);
		//System.out.print("checkCode1:"+checkCode1);
		String uid = request.getParameter("activationid");
		String sql = "select * from cc_activate where i_uid="+uid+" and b_deleted=0 limit 1";
		Member member = MemberDao.findMemberByID(uid);
		String path = request.getContextPath(); 
		if(member ==null){
			request.getSession().setAttribute("checkResult", "不存在此激活链接");
//			response.sendRedirect("Member/userinfo.jsp");
			request.getRequestDispatcher("/Member/tips.jsp?checkCode="+checkCode1+"&actid="+uid).forward(request, response);
			
		}else{
			request.getSession().setAttribute(Constant.SESSION_USER, member);
			request.getSession().setAttribute("uid",member.getUid());
			request.getSession().setAttribute("loginid",member.getLoginid());
			request.getSession().setAttribute("email",member.getEmail());
			Activate activate = MemberDao.findActiveBySQL(sql);
			String checkCode2 = Md5Util.execute(member.getUid() + ":"+ activate.getCode());
			//System.out.print("checkCode2:"+checkCode2);
			String format = "yyyy-MM-dd HH:mm:ss"; 
			Calendar todayStart = Calendar.getInstance();  
			todayStart.set(Calendar.HOUR_OF_DAY, 0);  
			todayStart.set(Calendar.MINUTE, 0);  
			todayStart.set(Calendar.SECOND, 0);  
			todayStart.set(Calendar.MILLISECOND, 0); 
			if(member.getState()==2){//邮箱已激活
				request.getSession().setAttribute("checkResult", "已激活");
				request.getRequestDispatcher("/Member/userinfo.jsp?checkCode="+checkCode1+"&actid="+uid).forward(request, response);
			}
			else if(member.getState()==3){//完成个人信息
				response.sendRedirect("/Member/login.jsp");
			}			
			else {//未激活
				try {//当天有效，true为失效
					if(DateUtils.isBefore(format, activate.getCreateTime(), format, DateUtils.format(todayStart.getTime(), format))){
						request.getSession().setAttribute("checkResult", "链接已失效");
						request.getRequestDispatcher("/Member/tips.jsp?checkCode="+checkCode1+"&actid="+uid).forward(request, response);
					}else { //有效
						if(checkCode1.equals(checkCode2)){
							//激活成功,更新状态
							LOG.info("ID:"+member.getUid()+"激活成功！");
							member.setState(2);
							MemberDao.updateMember(member);
							request.getSession().setAttribute("checkResult", "激活成功");
//							response.sendRedirect("Member/userinfo.jsp");
    					    request.getRequestDispatcher("/Member/userinfo.jsp?checkCode="+checkCode1+"&actid="+uid).forward(request, response);
    					    MemberDao.delActivate(member.getUid());//删除使用过的激活码
						}else {//激活失败
							request.getSession().setAttribute("checkResult", "激活失败");
//							response.sendRedirect("Member/userinfo.jsp");
							request.getRequestDispatcher("/Member/tips.jsp?checkCode="+checkCode1+"&actid="+uid).forward(request, response);
						}
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}