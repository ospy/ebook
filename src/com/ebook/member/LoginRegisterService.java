package com.ebook.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import com.ebook.entity.Member;
import com.ebook.member.dao.*;
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
		String sql = "SELECT COUNT(1) FROM cc_member a WHERE a.s_loginid= '"+userName+"' and b_deleted=0";
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
		String sql = "SELECT COUNT(1) FROM cc_member WHERE s_mail='"+email+"'  and b_deleted=0";
		int count= DatabaseTools.getCount(sql);
		if (count > 0) {
			bool = false;
		}
		return bool;
	}

	
	/**
	 * 检查手机号的唯一性
	 * 
	 * @param mobile
	 * @return
	 */
	public static boolean checkMobile(String mobile) {
		boolean bool = true;
		String sql = "SELECT COUNT(1) FROM cc_member_info WHERE s_mobile='"+mobile+"' and b_deleted=0";
		int count= DatabaseTools.getCount(sql);
		if (count > 0) {
			bool = false;
		}
		return bool;
	}
	
	/**
	 * 检查MemberInfo中i_uid的唯一性
	 * 
	 * @param mobile
	 * @return
	 */
	public static boolean checkMemberInfoUid(String i_uid) {
		boolean bool = true;
		String sql = "SELECT COUNT(1) FROM cc_member_info WHERE i_uid='"+i_uid+"' and b_deleted=0";
		int count= DatabaseTools.getCount(sql);
		if (count > 0) {
			bool = false;
		}
		return bool;
	}
	
	public static Member  registerSave(String loginid,String email,String password,String ip,String city) {
		Member member = null;
		int i_state=0;
		int b_deleted=1;
		//当前时间
		String date = DateUtils.format(null);
		Connection connection  = DBPool.getInstance().getConnection();
		String sql = "insert into cc_member(s_loginid,s_mail,s_password,ip,city,i_state,s_create_time,b_deleted) values(?,?,?,?,?,?,?,?)";
		int result = 0;
		PreparedStatement  ptst = null;
		try {
			ptst = connection.prepareStatement(sql);
			ptst.setString(1, loginid);
			ptst.setString(2, email);
			ptst.setString(3, password);
			ptst.setString(4, ip);
			ptst.setString(5, city);
			ptst.setInt(6, i_state);
			ptst.setString(7, date);
			ptst.setInt(8, b_deleted);
			result = ptst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DatabaseTools.closeStatement(ptst);
			DatabaseTools.closeConnection(connection);
		}
		if(result>0){			
			member = new Member();
			member=MemberDao.findNewMemberByEmail(email);//根据邮箱查出新注册的用户信息
			
		}
		

		return member;
	}
	
	//插入新建的空账户
	public static Boolean  insertAccount(Member member){
		boolean result=false;
		if(member!=null){
			int uid=Integer.valueOf(member.getUid());
			String date = DateUtils.format(null);
			//注册时建立新账户,初始账户0点
			String sql1 = "insert into cc_integral(i_uid,i_value,s_type,i_old_value,i_new_value,s_create_time) values(?,?,?,?,?,?)";
			Connection connection1  = DBPool.getInstance().getConnection();
			PreparedStatement  ptst1 = null;
			try {
				ptst1 = connection1.prepareStatement(sql1);
				ptst1.setInt(1, uid);
				ptst1.setString(2,"0");
				ptst1.setInt(3, 1);
				ptst1.setInt(4, 0);
				ptst1.setInt(5, 0);
				ptst1.setString(6, date);
				ptst1.executeUpdate();
				result=true;
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DatabaseTools.closeStatement(ptst1);
				DatabaseTools.closeConnection(connection1);
			}
		}
		return result;
	}
}
