package com.ebook.utils;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ebook.constant.Constant;
import com.ebook.entity.Activate;
import com.ebook.entity.Member;
import com.ebook.member.dao.MemberDao;

import freemarker.template.TemplateException;


public class SendEmailUtil {
	private static final String CHECK_CODE = "checkCode";
	
	public static void sendEmail(String email,HttpServletRequest request) throws IOException, TemplateException{
		Member member = MemberDao.findMemberByEmail(email);
		String loginid = member.getLoginid();
		Activate activate = new Activate();
		// 邮箱激活验证码
		activate.setCode(StringUtil.getvalidcode());
		String checkCode =Md5Util.execute(email + ":"+ activate.getCode());
		String url =  getServiceHostnew(request)+"/activateAccount?activationid="   
		        + member.getLoginid() + "&" + CHECK_CODE + "=" + checkCode; 
		LOG.info("邮箱激活连接："+url);
		
		Map<String, String> map = new HashMap<String, String>();
        if (loginid == null || loginid.equals("")) {
            map.put("name", "亲爱的用户");
        } else {
            map.put("name", loginid);
        }
        map.put("emailActiveUrl", url);
        String[] msg = getEmailResources("account-activate.ftl",map);
        // 发送邮件链接地址
	}
	
	 /**
     * 获取服务器的域名（包含端口号）
     * 
     * @param request   请求
     * @return          域名
     */
    public static String getServiceHostnew(HttpServletRequest request) {

        String serverPort = "";

        if (request.getServerPort() != 80) {
            serverPort = ":" + request.getServerPort();
        }

        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName()
                + serverPort + path + "/";

        return basePath;
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
