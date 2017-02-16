package com.ebook.member.dao;

import java.awt.ActiveEvent;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;

public class MemberDao {
	
	
	//根据uid查找Member
		public static Member findMemberByID(String uid){
			Member member = new Member();
			String sql = "select * from cc_member where i_uid='"+uid+"'";
			Connection conn = DBPool.getInstance().getConnection();
			Statement stmt;
			ResultSet rs = null;
			try {
				stmt = conn.createStatement();
				 rs = stmt.executeQuery(sql);
				 rs.next();
				 member.setUid(rs.getString("i_uid"));
				 member.setEmail(rs.getString("s_mail"));
				 member.setLoginid(rs.getString("s_loginid"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return member;
		}
	
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
			 member.setUid(rs.getString("i_uid"));
			 member.setEmail(rs.getString("s_mail"));
			 member.setLoginid(rs.getString("s_loginid"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	//根据email查找Active
	public static Activate findActiveByEmail(String email){
		Activate activate = new Activate();
		String sql = "select * from cc_activate where s_mail='"+email+"' order by i_id desc";
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
	
	
	//根据uid查找Active
		public static Activate findActiveByUid(String uid){
			Activate activate = new Activate();
			String sql = "select * from cc_activate where i_uid='"+uid+"' order by i_id desc";
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
		
		
		//保存activate
		public static void saveActivate(Activate activate){
			Member member = activate.getMember();
			String sql = "insert into cc_activate(i_uid,s_loginid,s_act_code,s_create_time,s_type) values(?,?,?,?,?)";
			Connection conn = DBPool.getInstance().getConnection();
			PreparedStatement ptst = null;
			try {
				ptst = conn.prepareStatement(sql);
				ptst.setString(1, member.getUid());
				ptst.setString(2, member.getLoginid());
				ptst.setString(3, activate.getCode());
				ptst.setString(4, activate.getCreateTime());
				ptst.setString(5, activate.getStype());
				ptst.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DatabaseTools.closeStatement(ptst);
				DatabaseTools.closeConnection(conn);
			}
			
			
		}
}
