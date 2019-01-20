package com.ebook.member.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;

import com.ebook.entity.BookList;
import com.ebook.utils.DBPool;
import com.ebook.utils.DateUtils;

public class LoginHistory {
	public static void loginin(String loginid,String area,String IP) {
	String date=DateUtils.format(null);	
	String sql = "insert into login_history(loginid,area,IP,intime) VALUES('"+loginid+"','"+area+"','"+IP+"','"+date+"')";
	Connection conn = DBPool.getInstance().getConnection();
	
	Statement stmt=null;
   
   
	try {

		stmt = conn.createStatement();
		stmt.executeUpdate(sql);

		}
		  
	 catch (SQLException e) {
		e.printStackTrace();		
	}

 finally{
    	   try {
    		 
			stmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	   try {	    		 
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       }	
	
     
    }
	
	public static void loginout(String loginid) {
		String date=DateUtils.format(null);	
		String sql = "update login_history set outtime='"+date+"',b_deleted=1  where loginid='"+loginid+"' and b_deleted=0";
		Connection conn = DBPool.getInstance().getConnection();
		
		Statement stmt=null;
   
		try {

			stmt = conn.createStatement();
			stmt.executeUpdate(sql);

			}
			  
		 catch (SQLException e) {
			e.printStackTrace();		
		}

	 finally{
	    	   try {
	    		 
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	   try {	    		 
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       }	
		
	     
	    }
}
