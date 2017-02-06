package com.ebook.member;

import com.ebook.utils.DatabaseTools;

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
		String sql = "SELECT COUNT(1) FROM cc_member a WHERE a.s_loginid= "+userName;
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

	
	
}
