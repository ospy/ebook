/**
 * 
 */
/**
 * @author admin
 *
 */
package com.ebook.list.dao;


import java.awt.ActiveEvent;
import java.awt.List;
import java.awt.Menu;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sound.midi.MetaEventListener;

import com.ebook.entity.Activate;
import com.ebook.entity.BookList;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;
import com.ebook.utils.ResultsetToList;

public class ListDao {
	
	/**
	 * 鐧诲綍楠岃瘉
	 * @param uid
	 * @return
	 */
	public static BookList getBookList(String discuID){
		
		String sql = "select * from cc_discu where i_discuid < "+discuID+" ";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt;
		ResultSet rs = null;
		try {
			BookList booklist = new BookList();
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(sql);
			 while(rs.next()){
				 System.out.println("xxx："+rs.getString("s_desc"));
				 booklist.setS_desc(rs.getString("s_desc"));
				
			 }
			 return booklist;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{  
//          DBconn.close(rs, stm, ps);  
        }  
        System.out.println("该对象不存在");  
        return null;  
		 
	}
}