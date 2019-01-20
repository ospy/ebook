package com.ebook.utils;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;

import com.ebook.constant.Constant;
import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.member.dao.MemberDao;

import freemarker.template.TemplateException;

public class SendPsd {
	public static String sendEmail(String email,String Loginid,String IP,String city) throws IOException, TemplateException{
		
		Member member = MemberDao.findMemberByEmail(email);
		String uid = member.getUid();
		String memo=city+":"+IP;
		String sql = "select count(1) from cc_findpsw where s_loginid="+Loginid+" and s_dest='"+email+"' and b_deleted=0";
		int count = DatabaseTools.getCount(sql);
		if(count>0){//将b_deleted置为1
			String sql1 = "update cc_findpsw set b_deleted=1 where i_uid="+uid+"";
			DatabaseTools.update(sql1);
		};
		// 重置的密码
		String actcode = StringUtil.getvalidcode();
		
		// 发送邮件链接地址
		String psd = "重置密码为：" +actcode; 
		LOG.info(psd);
		//插入找回密码记录表
		String sql2 = "insert into cc_findpsw(i_uid,s_loginid,s_dest,s_act_code,s_type,memo,b_send,s_create_time,b_deleted) values (?,?,?,?,?,?,?,?,?)";
		Connection conn = DBPool.getInstance().getConnection();
		PreparedStatement ptst = null;
		try {
			ptst = conn.prepareStatement(sql2);
			ptst.setInt(1,Integer.parseInt(uid));
			ptst.setString(2, Loginid);
			ptst.setString(3, email);
			ptst.setString(4, actcode);
			ptst.setString(5, "MAIL");
			ptst.setString(6, memo);
			ptst.setString(7, "1");
			ptst.setString(8, DateUtils.format(""));
			ptst.setInt(9, 0);
			ptst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DatabaseTools.closeStatement(ptst);			
		}
		//保存重置密码
		LOG.info("保存密码");
		
		//发送内容
		Map<String, String> map = new HashMap<String, String>();
        if (Loginid == null || Loginid.equals("")) {
            map.put("name", "亲爱的用户");
        } else {
            map.put("name", Loginid);
        }
        map.put("emailActiveUrl", psd);
        String[] msg = getEmailResources("findpsd.ftl",map);
        String subject = "imed120.com帐号激活邮件";
        String context = msg[1];
        String []address = {email};
        // 发送邮件
        final Properties props = PropertiesUtils.loadProps("/config/user/emailInfo.properties");
        final String addressFrom = props.getProperty("mailname");
       
       String type ="text/html;charset="+ Constant.CHARSET_DEFAULT;
       boolean sendresult = false;
       boolean changeresult=false;
      //sendresult = EmailUtils.sendEmail(session, new Date(), addressFrom, subject, context, type, null, null, address);
       if(!sendresult){
    	   try {
    		   sendresult =	EmailUtils.sendmail(type,email,new Date(),"imed120@sina.com","smtp.sina.com", subject, context);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       }
       else if(!sendresult){
    	   try {
    		   sendresult =	EmailUtils.sendmail(type,email,new Date(),"imed120@sohu.com","smtp.sohu.com", subject, context);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       }; 
    	 //邮件发送成功重置密码  
    	if(sendresult==true){    		
    		String newpwd=DigestUtils.md5Hex(actcode);
     			String sql3 = "{call updatepwd(?,?)}";
     			CallableStatement call1;
     			try {
     				call1 = conn.prepareCall(sql3);
     				call1.setString(1,uid);
     				call1.setString(2,newpwd);
     				call1.execute();
     				call1.close();    				
     				changeresult=true;			
     			    
     			} catch (SQLException e) {
     				// TODO Auto-generated catch block
     				e.printStackTrace();
     			}
     			finally{
     				DatabaseTools.closeConnection(conn);
     			}	
    	};   
  		 
       if(sendresult==true&&changeresult==true){
    	   //发送邮件成功并且修改密码成功
    	   return "1";
       }
       else{
    	   return "0";}
       //发送之后，将cc_member表i_state置为1
       //member.setState(1);
        //更新member
        //MemberDao.updateMember(member);
	} 
    
    /**
     * 得到邮件资源
     * 
     * @param modelName
     *            资源名称
     * @param map
     *            待填充字符
     * @return 数组[主题][内容]
     * @throws IOException
     *             文件读取异常
     * @throws TemplateException
     *             文件解析异常
     */
    public static String[] getEmailResources(String modelName, Map map)
            throws IOException, TemplateException {

        String msg = FreeMarkerUtil.execute("config/marker/email/" + modelName,
                Constant.CHARSET_DEFAULT, map);

        int index = msg.indexOf("\n");

        return new String[] { msg.substring(0, index - 1),
                msg.substring(index + 1) };
    }
}
