package com.ebook.DoOrder;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.ebook.constant.Constant;
import com.ebook.entity.Member;
import com.ebook.entity.Order;
import com.ebook.utils.DBPool;
import com.ebook.utils.DateUtils;
import com.mchange.v2.cfg.PropertiesConfigSource.Parse;

/**
 * Servlet implementation class checkOrder
 */
@WebServlet("/CheckOrder")
public class CheckOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		
		String type = request.getParameter("type");
		String price = request.getParameter("price");
		
		HttpSession session = request.getSession();
		String uid=(String) session.getAttribute("uid");
		
		PrintWriter out = response.getWriter();
		if(uid!=null){
		String sql = "select  * from orderlist where i_uid='"+uid+"' and type='"+type+"' and recharge_price="+price+" and pay_state=1";
		 
		Connection conn = DBPool.getInstance().getConnection();
		Statement stmt=null;
		ResultSet rs = null;
		String result="";
		ArrayList<Order> list=new ArrayList<Order>();
		SimpleDateFormat simdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);			
			while(rs.next()){
				if(rs.getString("recharge_price").equals(price)){
					Order order=new Order();   
					order.setOrder_id(rs.getString("order_id"));
					order.setI_uid(rs.getString("i_uid"));
					order.setS_loginid(rs.getString("s_loginid"));
					order.setType(rs.getString("type"));
					order.setRecharge_price(rs.getString("recharge_price"));
					order.setReal_price(rs.getString("real_price"));
					order.setPay_state(rs.getString("pay_state"));
					order.setGenerate_time(rs.getString("generate_time"));
					order.setDeadline_time(rs.getString("deadline_time"));
					order.setPay_time(rs.getString("pay_state"));					
					try {
						  long now = new Date().getTime();
						  long deadline = simdate.parse(rs.getString("deadline_time")).getTime();
						  int leftsecond = (int)((deadline - now) / 1000);
						  order.setLeft_time(String.valueOf(leftsecond));
						  //System.out.printf("lefttime："+leftsecond);						
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}//60秒后的时间
					list.add(order);
			        }				
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
		out.print(result);  
	  }
	}
}
