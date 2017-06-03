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
	 * 
	 * @param uid
	 * @return
	 */
	public static ResultSet getBookList(String spid, String Time,	int pageIndex, int pageListSize, String order) {

		String sql = "SELECT a.i_discuid,a.s_desc,a.i_discuPrice,a.i_click_times,a.i_download_times,a.s_filetypes,a.s_loginid,a.s_imgurl,a.s_create_time  from cc_discu a where i_discuid in (SELECT DISTINCT i_discuid from cc_speciality_link_discu b "	+ spid+ ")  "+ Time+ "  "+ order+ " LIMIT "+ pageIndex+","+ pageListSize +"";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt;
		ResultSet rs = null;

		try {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		return rs;  

	}

	/**
	 * 鐧诲綍楠岃瘉
	 * 
	 * @param uid
	 * @return
	 */
	public static ResultSet getCount(String spid, String Time) {

		String sql = "SELECT count(*) as Count  from cc_discu a where i_discuid in (SELECT DISTINCT i_discuid from cc_speciality_link_discu b " + spid + ") " + Time + "";
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt;
		ResultSet rs = null;

		try {

			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

		} catch (SQLException e) {
			e.printStackTrace();
			
		}

		
		return rs;
	}
}