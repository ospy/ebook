package com.ebook.News.Dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import java.util.ArrayList;

import com.ebook.entity.BookList;
import com.ebook.entity.News;
import com.ebook.utils.DBPool;
import com.ebook.utils.RsToJson;

import org.json.*;

import net.sf.json.JSONArray;
public class NewsDao {
	//获取新闻列表
	public static String getNewsList()  {

		String sql = "SELECT *  from News  where  b_deleted=0 ORDER BY datetime DESC limit 8";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt=null;
		ResultSet rs = null;
		String result="";
		ArrayList<News> list=new ArrayList<News>();
		try {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				News news=new News();   
				news.setId(rs.getString("id"));    
				news.setTitle(rs.getString("title"));
				news.setDatetime(rs.getString("datetime"));
				list.add(news);
			        }
					
				 
	
			JSONArray jsonArray = JSONArray.fromObject(list);
			
			result = jsonArray.toString();
           
				
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
		  return result;
   }
	
	//获取新闻详情
	public static String getNewsDetail(String nid)  {

		String sql = "SELECT *  from News  where id='"+nid+"' and  b_deleted=0";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt=null;
		ResultSet rs = null;
		String result="";
		try {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			result = RsToJson.resultSetToJson(rs);
           
				
		} catch (SQLException e) {
			e.printStackTrace();
			
		}catch (JSONException e) {
			// TODO Auto-generated catch block
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
		  return result;
   }
}