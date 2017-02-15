package com.ebook.emailservice;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.MimeUtility;

import com.ebook.constant.Constant;
import com.ebook.utils.EmailUtils;
import com.ebook.utils.LOG;

public class BaseEmailService {

    /**
     * Session
     */
    private Session session;
    
    /**
     * addressFrom
     */
    private String addressFrom;

    public void setProperties(String path) throws IOException {
        
        final Properties props = PropertiesLoaderUtils.loadAllProperties(path);
        
        this.addressFrom = props.getProperty("mailname");
        this.session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(addressFrom, props
                        .getProperty("mailpassword"));
            }

        });
        LOG.info("--->初始化发送邮件服务成功！");
    }
    

    /**
     * 发送邮件 支持邮件群发
     * 
     * @param date
     *            发送时间
     * @param subject
     *            主题(需要自行转码)
     * @param context
     *            内容
     * @param type
     *            内容类型
     * @param address
     *            接收者
     */
    public void sendEmail(final Date date, final String subject,
            final String context, final String type, final String... address) {

        new Thread(new Runnable() {

            public void run() {

                EmailUtils.sendEmail(session, date, addressFrom, subject,
                        context, type, null, null, address);

            }
        }).start();

    }

    /**
     * 发送邮件 支持邮件群发
     * 
     * @param subject
     *            主题
     * @param context
     *            内容
     * @param address
     *            接收者
     */
    public void sendEmail(String subject, String context, String... address) {
        try {
            subject = MimeUtility.encodeText(subject, Constant.CHARSET_DEFAULT,
                    "B");
        } catch (UnsupportedEncodingException e) {
            LOG.error("邮件主题转码失败！", e);
        }
        sendEmail(new Date(), subject, context, "text/html;charset="
                + Constant.CHARSET_DEFAULT, address);
    }

}