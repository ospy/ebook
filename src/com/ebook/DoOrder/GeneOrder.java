package com.ebook.DoOrder;

import java.io.ByteArrayOutputStream; 
import java.io.IOException; 
import java.io.InputStream; 
import java.io.InputStreamReader; 
import java.io.PrintWriter; 
   


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
import javax.servlet.http.HttpSession;

import org.apache.xalan.xsltc.compiler.util.CompareGenerator;
import org.apache.xpath.operations.And;

import net.sf.json.JSONArray;

import com.ebook.entity.Order;
import com.ebook.utils.DBPool;
import com.ebook.utils.DatabaseTools;
import com.ebook.utils.DateUtils;
import com.gargoylesoftware.htmlunit.javascript.host.Window;

import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

/**
 * Servlet implementation class DoPay
 */
@WebServlet("/GeneOrder")
public class GeneOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GeneOrder() {
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
        response.setContentType("text/html;charset=utf-8"); 
        request.setCharacterEncoding("utf-8"); 
		String type = request.getParameter("type");
		String price = request.getParameter("price");
		
		HttpSession session = request.getSession();
		String uid=(String) session.getAttribute("uid");
		String username=(String) session.getAttribute("username");
		PrintWriter out = response.getWriter();
		String result="";	
			
		if(uid!=null){ 
			//当前时间
		    String date = DateUtils.format(null);       		
		    SimpleDateFormat datef = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  		
			List<Double> findresult = new ArrayList<Double>();
				try {
					String sql = "select real_price from orderlist where  type='"+type+"' and recharge_price="+price+" and pay_state=1 order by real_price ASC" ;			 
					Connection conn = DBPool.getInstance().getConnection();
					Statement stmt=null;
					ResultSet rs = null;
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						System.out.print(rs.getString(1));
						findresult.add(Double.valueOf(rs.getString(1)));	//已占用价格二维码存入数组						
					} 
					stmt.close();
					conn.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				//处理插入订单记录 2种情况：1该价格下无占用二维码2该价格下有占用二维码
				Connection conn  = DBPool.getInstance().getConnection();

				String sql1 = "{call InsertOrder(?,?,?,?,?,?,?,?,?)}";
				int orderid = 0;
				Timestamp genetime;
				Timestamp deadtime;
				double dbprice = 0;
				CallableStatement call1;
				List<Order> list = new ArrayList<Order>();
				if(findresult==null||findresult.size()==0){//1该价格下无占用二维码   	           		
					
            		PreparedStatement  ptst = null;
            		try {
            			Order order=new Order();   

            			dbprice=Double.valueOf(price); 
            			DecimalFormat df = new DecimalFormat("#.00");//此为保留1位小数，若想保留2位小数，则填写#.00  ，以此类推
        		    	String realprice = df.format(dbprice);		
            	    	call1 = conn.prepareCall(sql1);
        				call1.setString(1,uid);
        				call1.setString(2,username);
        				call1.setString(3,type);
        				call1.setString(4,price);
        				call1.setDouble(5,dbprice);
        				call1.setInt(6,1);
        				call1.registerOutParameter(7,Types.INTEGER);
        				call1.registerOutParameter(8,Types.TIMESTAMP);
        				call1.registerOutParameter(9,Types.TIMESTAMP);
        				call1.execute();
        				orderid=call1.getInt(7);
        				genetime=call1.getTimestamp(8);
        				deadtime=call1.getTimestamp(9);
        				
        				order.setLeft_time("300");
        				order.setReal_price(realprice);
    					order.setOrder_id(String.valueOf(orderid));
    					order.setGenerate_time(String.valueOf(datef.format(genetime)));
    					order.setDeadline_time(String.valueOf(datef.format(deadtime)));
    					list.add(order);
        				JSONArray jsonArray = JSONArray.fromObject(list);			
        				result = jsonArray.toString();	
        				call1.close();
        				Thread t=new MyThread(orderid,deadtime);
	        			t.start();
            		} catch (SQLException e) {
            			e.printStackTrace();
            		}finally{
            			DatabaseTools.closeStatement(ptst);
            			DatabaseTools.closeConnection(conn);
            		}
                }			
                else{ //2该价格下有占用二维码            	
            		
            		 dbprice=compare(Integer.parseInt(price),findresult);
            		 if(dbprice>(Double.valueOf(price)-0.05)){
	            		PreparedStatement  ptst = null;
	            		try { 
	            			Order order=new Order();
	            			call1 = conn.prepareCall(sql1);
	        				call1.setString(1,uid);
	        				call1.setString(2,username);
	        				call1.setString(3,type);
	        				call1.setString(4,price);
	        				call1.setDouble(5,dbprice);
	        				call1.setInt(6,1);
	        				call1.registerOutParameter(7,Types.INTEGER);
	        				call1.registerOutParameter(8,Types.TIMESTAMP);
	        				call1.registerOutParameter(9,Types.TIMESTAMP);
	        				call1.execute();
	        				orderid=call1.getInt(7);
	        				genetime=call1.getTimestamp(8);
	        				deadtime=call1.getTimestamp(9);
	        				DecimalFormat df = new DecimalFormat("#.00");//此为保留1位小数，若想保留2位小数，则填写#.00  ，以此类推
	        		    	String realprice = df.format(dbprice);		
	        				
	        		    	order.setLeft_time("300");
	        		    	order.setReal_price(realprice);
	    					order.setOrder_id(String.valueOf(orderid));
	    					order.setGenerate_time(String.valueOf(datef.format(genetime)));
	    					order.setDeadline_time(String.valueOf(datef.format(deadtime)));
	    					list.add(order);
	        				JSONArray jsonArray = JSONArray.fromObject(list);			
	        				result = jsonArray.toString();	
	        				call1.close();
		        			Thread t=new MyThread(orderid,deadtime);
		        			t.start();
	            		} catch (SQLException e) {
	            			e.printStackTrace();
	            		}finally{
	            			DatabaseTools.closeStatement(ptst);
	            			DatabaseTools.closeConnection(conn);
	            		}
            		 }
            		 else{
            			 result="-1";
            		 }
                }
	    
		out.print(result);		   
	   }       		    
		else{
			response.sendRedirect("/Member/login.jsp");
		} 

	}

	private static Double compare(int price,List<Double> findresult) {
		Double[] find = new Double[findresult.size()];
	    //使用for循环得到数组
	    for(int i = 0; i < findresult.size();i++){
	       find[i] = findresult.get(i);
	    }
		Double[] src=new Double[]{20.00,19.99,19.98,19.97,19.96};
		
        if(price==50){
			src=new Double[]{50.00,49.99,49.98,49.97,49.96};
		}
		else if(price==100){
			src=new Double[]{100.00,99.99,99.98,99.97,99.96};
		}
		else if(price==200){
			src=new Double[]{200.00,199.99,199.98,199.97,199.96};
		};
       
        List<Double> result =new ArrayList<Double>();
		for (Double o : src) {
			/*
			 * 筛选出两个数组中相同的值，>= 0 表示相同，< 0 表示不同 。
			 * 有相同值是返回元素的下标值。
			 * 此处采用的是 "二分搜索法来搜索指定数组"。
			 * */			
			if(Arrays.binarySearch(find, o) < 0){			
				result.add(o);
			}
		}
		if(result != null && result.size()!=0){
		    Collections.sort(result, Collections.reverseOrder());
		    Double max=	result.get(0);
		    return max;
	    }else{
	    	 return  0.0;
	    }
		
	  
	}

	class MyThread extends Thread{
		
		private int orderid;
		private Timestamp deadtime;

	    public MyThread(int orderid,Timestamp deadtime) {
	        this.orderid = orderid;
	        this.deadtime=deadtime;
	    }
	//创建Thread子类
	    public void run() {
	            Timer t=new Timer();	           
	            t.schedule(new MyTask(orderid),deadtime);				
	            }
	            
	    }
	
	class MyTask extends TimerTask{

	    private int orderid;

		public MyTask(int orderid) {
	    	 this.orderid = orderid;
		}
		@Override
	    public void run() {
			//超时关闭订单
			String sql2 = "update orderlist set pay_state=2 where pay_state=1 and order_id="+ orderid;			 
			Connection conn = DBPool.getInstance().getConnection();
			Statement stmt=null;			
			try {
				stmt = conn.createStatement();
				stmt.executeUpdate(sql2);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try {
					stmt.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
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
}
