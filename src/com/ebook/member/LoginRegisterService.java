package com.ebook.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import com.ebook.entity.Member;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;
import com.ebook.utils.DateUtils;


public class LoginRegisterService {
	/**
	 * 检查用户名是否唯一
	 * @param userName
	 * @return 如果使用了返回为false，反之为true
	 */
	public static boolean checkUserName(String userName) {
		if(userName == null){
			return false;
		}
		if(userName.trim().equals("")){
			return false;
		}
		String sql = "SELECT COUNT(1) FROM cc_member a WHERE a.s_loginid= '"+userName+"'";
		int count= DatabaseTools.getCount(sql);
		if(count>0){
			return false;
		}
		return true;
	}
	
	/**
	 * 检查邮箱的唯一性
	 * 
	 * @param email
	 * @return
	 */
	public static boolean checkEmail(String email) {
		boolean bool = true;
		String sql = "SELECT COUNT(1) FROM cc_member WHERE s_mail='"+email+"'";
		int count= DatabaseTools.getCount(sql);
		if (count > 0) {
			bool = false;
		}
		return bool;
	}

	
	public static Member  registerSave(String loginid,String email,String password) {
		Member member = null;
		//当前时间
		String date = DateUtils.format(null);
		Connection connection  = DBPool.getInstance().getConnection();
		String sql = "insert into cc_member(s_loginid,s_mail,s_password,s_create_time) values(?,?,?,?)";
		int result = 0;
		PreparedStatement  ptst = null;
		try {
			ptst = connection.prepareStatement(sql);
			ptst.setString(1, loginid);
			ptst.setString(2, email);
			ptst.setString(3, password);
			ptst.setString(4, date);
			result = ptst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DatabaseTools.closeStatement(ptst);
			DatabaseTools.closeConnection(connection);
		}
		if(result>0){
			member = new Member();
			member.setEmail(email);
			member.setLoginid(loginid);
			member.setCreateTime(date);
		}
		return member;
	}
	
	
}
