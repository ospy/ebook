package com.ebook.member.dao;

import java.awt.ActiveEvent;
import java.awt.List;
import java.awt.Menu;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.mail.Session;
import javax.servlet.http.HttpSession;
import javax.sound.midi.MetaEventListener;
import javax.servlet.http.HttpSession;

import org.apache.xpath.operations.And;

import com.ebook.constant.Constant;
import com.ebook.entity.Activate;
import com.ebook.entity.BookList;
import com.ebook.entity.Member;
import com.ebook.entity.MemberInfo;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;

public class MemberDao {
	
	/**
	 * 鐧诲綍楠岃瘉
	 * @param uid
	 * @return
	 */
	public static Member userLogin(String uid,String pwd){
	
		Member member = new Member();
		String sql = "select i_uid,s_mail,s_loginid,s_level,i_state from m_userlist where (s_loginid='"+uid+"' or s_mail='"+uid+"' or s_mobile='"+uid+"') and s_password ='"+pwd+"' and b_deleted=0";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt=null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 if(rs.next()){					
				 member.setUid(rs.getString("i_uid"));
				 member.setEmail(rs.getString("s_mail"));
				 member.setLoginid(rs.getString("s_loginid"));				
				 member.setState(rs.getInt("i_state"));
				 member.setS_level(rs.getString("s_level"));
			 }
			 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DatabaseTools.closeResultset(rs);
			DatabaseTools.closeStatement(stmt);
			DatabaseTools.closeConnection(conn);
			}
	return member;	
	}
	

	/**
	 * 鏍规嵁uid鏌ユ壘Member
	 * @param uid
	 * @return
	 */
		public static Member findMemberByID(String uid){
			Member member = new Member();
			String sql = "select * from cc_member where i_uid='"+uid+"' and b_deleted=0";
			Connection conn = DBPool.getInstance().getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.createStatement();
				 rs = stmt.executeQuery(sql);
				 if(rs.next()){
					 member.setUid(rs.getString("i_uid"));
					 member.setEmail(rs.getString("s_mail"));
					 member.setIp(rs.getString("ip"));
					 member.setCity(rs.getString("city"));
					 member.setLoginid(rs.getString("s_loginid"));
					 member.setPassword(rs.getString("s_password"));
					 member.setState(rs.getInt("i_state"));
					 member.setOnline(rs.getInt("i_online"));
				 }else{
					 return null;
				 }
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally{
				DatabaseTools.closeResultset(rs);
				DatabaseTools.closeStatement(stmt);
				DatabaseTools.closeConnection(conn);
				}
			return member;
		}
	
		/**
		 * 鏍规嵁email鏌ユ壘Member
		 * @param email
		 * @return
		 */
	public static Member findMemberByEmail(String email){
		Member member = new Member();
		String sql = "select * from cc_member where s_mail='"+email+"' and b_deleted=0";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 rs.next();
			 member.setUid(rs.getString("i_uid"));
			 member.setEmail(rs.getString("s_mail"));
			 member.setLoginid(rs.getString("s_loginid"));
			 member.setPassword(rs.getString("s_password"));
			 member.setState(rs.getInt("i_state"));
			 member.setB_deleted(rs.getInt("b_deleted"));
			 //member.setOnline(rs.getInt("i_online"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			DatabaseTools.closeResultset(rs);
			DatabaseTools.closeStatement(stmt);
			DatabaseTools.closeConnection(conn);
			}
		return member;
	}
	/**
	 * 鏍规嵁email鏌ユ壘Member
	 * @param email
	 * @return
	 */
public static Member findNewMemberByEmail(String email){
	//查询新插入用户记录，如果邮件发送成功才将状态设置为可用i_state=1 and b_deleted=0
	Member member = new Member();
	String sql = "select * from cc_member where s_mail='"+email+"' and i_state<2  ORDER BY i_uid desc LIMIT 1";
	Connection conn = DBPool.getInstance().getConnection();
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		stmt = conn.createStatement();
		 rs = stmt.executeQuery(sql);
		 rs.next();
		 member.setUid(rs.getString("i_uid"));
		 member.setEmail(rs.getString("s_mail"));
		 member.setLoginid(rs.getString("s_loginid"));
		 member.setPassword(rs.getString("s_password"));
		 member.setState(rs.getInt("i_state"));
		 member.setB_deleted(rs.getInt("b_deleted"));
		 //member.setOnline(rs.getInt("i_online"));
	} catch (SQLException e) {
		e.printStackTrace();
	}
	finally{
		DatabaseTools.closeResultset(rs);
		DatabaseTools.closeStatement(stmt);
		DatabaseTools.closeConnection(conn);
		}
	return member;
}
	
	/**
	 * 鏇存柊Member
	 * @param member
	 */
	public static boolean updateMember(Member member){
		boolean result=false;
		String sql = "update cc_member set s_mail=?,s_password=?,i_state=?,i_online=?,b_deleted=? where i_uid=?";
		Connection conn = DBPool.getInstance().getConnection();
		PreparedStatement ptst = null;
		try {
			ptst = conn.prepareStatement(sql);
			ptst.setString(1, member.getEmail());
			ptst.setString(2, member.getPassword());
			ptst.setInt(3, member.getState());
			ptst.setInt(4, member.getOnline());
			ptst.setInt(5, member.getB_deleted());
			ptst.setString(6, member.getUid());
			ptst.executeUpdate();
			result=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DatabaseTools.closeStatement(ptst);
			DatabaseTools.closeConnection(conn);
		}
		return result;
	}
	
	
	
	/**
	 * 鏍规嵁email鏌ユ壘Active
	 * @param email
	 * @return
	 */
	public static Activate findActiveByEmail(String email){
		Activate activate = new Activate();
		String sql = "select * from cc_activate where s_mail='"+email+"' order by i_id desc";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt = null;
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
		finally{
			DatabaseTools.closeResultset(rs);
			DatabaseTools.closeStatement(stmt);
			DatabaseTools.closeConnection(conn);
			}
		return activate;
	}
	
	
	/**
	 * 鏍规嵁uid鏌ユ壘Active
	 * @param uid
	 * @return
	 */
		public static Activate findActiveByUid(String uid){
			Activate activate = new Activate();
			String sql = "select * from cc_activate where i_uid='"+uid+"' order by i_id desc";
			Connection conn = DBPool.getInstance().getConnection();
			Statement stmt = null;
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
			finally{
				DatabaseTools.closeResultset(rs);
				DatabaseTools.closeStatement(stmt);
				DatabaseTools.closeConnection(conn);
				}
			return activate;
		}
		
		/**
		 * 鏍规嵁SQL鏌ユ壘Active
		 * @param uid
		 * @return
		 */
		public static Activate findActiveBySQL(String sql){
			Activate activate = new Activate();
			Connection conn = DBPool.getInstance().getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			try {
				stmt = conn.createStatement();
				 rs = stmt.executeQuery(sql);
				 rs.next();
				 activate.setId(rs.getInt("i_id"));
				 activate.setCreateTime(rs.getString("s_create_time"));
				 activate.setCode(rs.getString("s_act_code"));
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally{
				DatabaseTools.closeResultset(rs);
				DatabaseTools.closeStatement(stmt);
				DatabaseTools.closeConnection(conn);
				}
			return activate;
		}
		
		/**
		 * 淇濆瓨activate
		 * @param activate
		 */
		public static void saveActivate(Activate activate){
			Member member = activate.getMember();
			String sql = "insert into cc_activate(i_uid,s_loginid,s_act_code,s_create_time,s_type,"
					+ "s_name,s_dest,b_overdue,b_send,b_deleted) values(?,?,?,?,?,?,?,?,?,?)";
			Connection conn = DBPool.getInstance().getConnection();
			PreparedStatement ptst = null;
			try {
				ptst = conn.prepareStatement(sql);
				ptst.setString(1, member.getUid());
				ptst.setString(2, member.getLoginid());
				ptst.setString(3, activate.getCode());
				ptst.setString(4, activate.getCreateTime());
				ptst.setString(5, activate.getStype());
				ptst.setString(6, activate.getSname());
				ptst.setString(7, activate.getSdest());
				ptst.setInt(8, activate.getBoverdue());
				ptst.setInt(9, activate.getBsend());
				ptst.setInt(10, activate.getBdeleted());
				ptst.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DatabaseTools.closeStatement(ptst);
				DatabaseTools.closeConnection(conn);
			}
			
		}
		/**
		 * 淇濆瓨activate
		 * @param activate
		 */
		public static void delActivate(String uid){
			//将使用过的激活码删除
			String sql = "update cc_activate set b_deleted=1 where b_deleted=0 and i_uid="+uid;
			Connection conn = DBPool.getInstance().getConnection();
			PreparedStatement ptst = null;
			try {
				ptst = conn.prepareStatement(sql);
				ptst.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DatabaseTools.closeStatement(ptst);
				DatabaseTools.closeConnection(conn);
			}
			
		}	
		
		/**
		 * 淇濆瓨MemberInfo
		 * @param MemberInfo
		 */
		public static void saveMemberInfo(MemberInfo memberInfo){
			
			String sql = "insert into cc_member_info(i_uid,s_occupation,s_name,s_mobile,s_address,"
					+ "s_capacity,s_spec,s_education,s_create_time) values(?,?,?,?,?,?,?,?,?)";
			Connection conn = DBPool.getInstance().getConnection();
			PreparedStatement ptst = null;
			try {
				ptst = conn.prepareStatement(sql);
				ptst.setString(1, memberInfo.getId());
				ptst.setString(2, memberInfo.getOccupation());
				ptst.setString(3, memberInfo.getName());
				ptst.setString(4, memberInfo.getMobile());
				ptst.setString(5, memberInfo.getAddress());
				ptst.setString(6, memberInfo.getCapacity());
				ptst.setString(7, memberInfo.getSpeciality());
				ptst.setString(8, memberInfo.getEducation());
				ptst.setString(9, memberInfo.getCreatetime());
				ptst.executeUpdate();
				Member member = MemberDao.findMemberByID(memberInfo.getId());
				member.setState(3);
				MemberDao.updateMember(member);
			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				DatabaseTools.closeStatement(ptst);
				DatabaseTools.closeConnection(conn);
			}
			
		}
}