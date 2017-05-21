package com.ebook.classeslist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;
import com.ebook.utils.ResultsetToList;

public class Classlist {

	//1.最新
	public static List getNewBooks(){ 
		Connection connection = DBPool.getInstance().getConnection();
		String sql="SELECT cc_discu.i_discuid,cc_discu.s_desc,cc_discu.s_imgurl,cc_discu.s_create_time FROM "+//
				"cc_discu where b_deleted=0   order by s_create_time desc limit 0, 10 ";
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			return ResultsetToList.convertList(rs);
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		finally{			
			DatabaseTools.closeConnection(connection);
		}
	}

}
