package cn.loosoft.stuwork.backmanage.service.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.util.StringUtils;

/**
 * 纯文本邮件服务类.
 * 
 * @author houbing.qian
 */
public class SimpleMailService {
	private static Logger logger = LoggerFactory.getLogger(SimpleMailService.class);

	private JavaMailSender mailSender;
	private String textTemplate;

	/**
	 * 发送纯文本的用户修改通知邮件.
	 */
	public void sendNotificationMail(String userName,String password,String email) {
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setFrom("easyeap@126.com");
		msg.setTo(email);
		msg.setSubject("用户修改通知");

		//将用户名与当期日期格式化到邮件内容的字符串模板
		String content = String.format(textTemplate, userName,password);
		msg.setText(content);

		try {
			mailSender.send(msg);
			logger.info("纯文本邮件已发送至{}", StringUtils.arrayToCommaDelimitedString(msg.getTo()));
		} catch (Exception e) {
			logger.error("发送邮件失败", e);
		}
	}

	/**
	 * Spring的MailSender.
	 */
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	/**
	 * 邮件内容的字符串模板.
	 */
	public void setTextTemplate(String textTemplate) {
		this.textTemplate = textTemplate;
	}
}
