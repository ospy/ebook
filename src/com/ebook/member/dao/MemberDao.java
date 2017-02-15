package com.ebook.member.dao;

import java.awt.ActiveEvent;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.utils.DBPool;

public class MemberDao {
	
	//根据email查找Member
	public static Member findMemberByEmail(String email){
		Member member = new Member();
		String sql = "select * from cc_member where s_mail='"+email+"'";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 rs.next();
			 member.setUid(rs.getString("s_uid"));
			 member.setEmail(rs.getString("s_email"));
			 member.setLoginid(rs.getString("s_loginid"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	//根据email查找Active
	public static Activate findActiveByEmail(String email){
		Activate activate = new Activate();
		String sql = "select * from cc_active where s_mail='"+email+"'";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 rs.next();
			 activate.setId(rs.getLong("i_id"));
			 activate.setCreateTime(rs.getString("s_create_time"));
			 activate.setCode(rs.getString("s_act_code"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return activate;
	}
}
