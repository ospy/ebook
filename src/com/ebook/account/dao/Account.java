package com.ebook.account.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;







import javax.servlet.http.HttpSession;

import com.ebook.utils.DBPool;
import com.ebook.utils.DateUtils;

public class Account {
	//处理账户变动，用户注册填写完整个人信息赠送下载点
		public static String Proc_Account(String uid,String operid, int type_id,String add_sub,int price,String message) {


			String date = DateUtils.format(null);
			String balance = Account.Balance(uid);//获取账户余额
			String result="null";			
			int new_value = Integer.parseInt(balance);
			String i_value="0";
			if(add_sub=="-"){
				if(new_value>=price){
					new_value = new_value-price;
					i_value="-"+price;
				}
				else{
					result="余额不足，请充值！";
					return result;
				}
			}
		    if(add_sub=="+"){				
					new_value = new_value+price;
					i_value="+"+price;
				}
			String sql = "insert into cc_integral(i_uid,i_value,s_type,i_discuid,s_create_time,i_old_value,i_new_value,s_message) VALUES("+uid+",'"+i_value+"',"+type_id+",'"+operid+"','"+date+"',"+balance+","+new_value+",'"+message+"')";
			Connection conn = DBPool.getInstance().getConnection();
			
			Statement stmt=null;
			   
			try {

				stmt = conn.createStatement();
				stmt.executeUpdate(sql);
				result="succ"; 
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
			return result;

		    }
		
	//获取账户余额
	public static String Balance(String uid) {

		String sql = "SELECT  i_new_value  from cc_integral  where i_uid ="+ uid+ " and b_deleted=0 ORDER BY i_id DESC limit 1";
		Connection conn = DBPool.getInstance().getConnection();		
		Statement stmt=null;
		ResultSet rs1 = null;
	    String result="";
		try {

			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(sql);
	
			while(rs1.next()){
				
				result = rs1.getString("i_new_value");
				
			}
		  
		} catch (SQLException e) {
			e.printStackTrace();
		}

	       finally{
	      	 
	    	   try {
	    		rs1.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
		return result;

	    }
	//查询该用户是否下载过该图书
	public static String IsDownload(String uid,String bookid) {

		String sql = "SELECT Count(*) count  from cc_integral  where i_uid ="+ uid+ " and i_discuid="+ bookid +" and b_deleted=0 ";
		Connection conn = DBPool.getInstance().getConnection();
		
		Statement stmt=null;
		ResultSet rs = null;
	    String result="";
	       
		try {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			 
			while(rs.next()){
			if(rs.getString("count")!="0"){
				result = rs.getString("count");
				
			}
			else{
				result = "0";
			}
		 }
			  
		} catch (SQLException e) {
			e.printStackTrace();
		}

	       finally{
	      	 
	    	   try {
	    		rs.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
		 return	result;

	    }
	
}
