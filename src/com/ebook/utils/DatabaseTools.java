package com.ebook.utils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseTools {
	
	public static String getAll(String sql) {
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		String result ="";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			result = "";
//			result = RsToJsons.resultSetToJson(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DatabaseTools.closeResultset(rs);
			DatabaseTools.closeStatement(stmt);
			DatabaseTools.closeConnection(conn);
		}
		return result;
	}
	
	public static int getCount(String sql){
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		int result =0;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			result = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DatabaseTools.closeResultset(rs);
			DatabaseTools.closeStatement(stmt);
			DatabaseTools.closeConnection(conn);
		}
		return result;
	}
	
	
	public static void closeResultset(ResultSet rs){
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void closeStatement(Statement stmt){
		if(stmt != null){
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public static void closeConnection(Connection conn){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
}
