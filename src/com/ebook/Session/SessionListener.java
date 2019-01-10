package com.ebook.Session;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.Map;
import com.ebook.member.dao.LoginHistory;
/**
 * Created by root on 17-9-28.
 */
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent event) {
    	 
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        //在session销毁的时候 把loginMap中保存的键值对清除
    	System.out.println("注销ID:"+event.getSession().getId().toString());
    	String sessionID = event.getSession().getId().toString();
    	String username="";
    	if(event.getSession().getAttribute("username")!=null){
    		  username = event.getSession().getAttribute("username").toString();
    	}
        
        if(username!=""){
            Map<String, String> loginMap = (Map<String, String>)event.getSession().getServletContext().getAttribute("loginMap");
            if(loginMap!=null){
            	loginMap.remove(username);
                event.getSession().getServletContext().setAttribute("loginMap",loginMap);
                LoginHistory.loginout(username);
            }                      
        }
        System.out.println("注销ID"+sessionID+"用户名："+username);
    }

}

