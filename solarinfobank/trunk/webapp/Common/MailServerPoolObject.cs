using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dimac.JMail.Smtp;
using Dimac.JMail;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{

    /// <summary>
    /// 邮件发送类
    /// </summary>
    public class MailServerPoolObject
    {
        private string _accountName = "";
        private string _password = "";
        private string _smtpServer = "mail.sohu.com";
        private int _smtpPort = 25;

        private DateTime previousSendDate =new DateTime() ;//上次发送时间
        // private DateTime previousErrorSendDate = DateTime.Now;//上次错误发送时间

        private static int difftimem = 2; 

        public MailServerPoolObject()
        { }

        public MailServerPoolObject(string accountName, string password, string smtpServer, int smtpPort)
        {
            this._accountName = accountName;
            this._password = password;
            this._smtpPort = smtpPort;
            this._smtpServer = smtpServer;
        }

        public string accountName{ get{return _accountName;} }

        ///
        /// 
        /// 是否满足时间间隔
        /// <p>
        /// <li>上次发送时间间隔要为2分钟</li>
        /// <li>上次错误发送时间间隔为5分钟</li>
        /// </p>
        /// @since  2010-10-14
        /// @author houbing.qian
        /// @return
        ///
        private bool isFullDate()
        {

            DateTime nowd = DateTime.Now;
            TimeSpan ts = nowd.Subtract(previousSendDate).Duration();
            if (previousSendDate.Year != 1 && (ts.TotalSeconds < difftimem))
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// 判断服务是否可用
        /// @since  2010-10-14
        /// @author houbing.qian
        /// @return
        /// </summary>
        /// <returns></returns>
        public bool isValid(){
            if(this.used){
                return false;
            }
            if(!this.isFullDate()){
                return false;
            }
            return true;
        }
        /**
         * 
         * 放回到服务池
         * @since  2010-10-14
         * @author houbing.qian
         */
        public void  close(){
            this.used = false;
            this.previousSendDate = DateTime.Now;

        }

        /// <summary>
        /// 发送邮件
        /// </summary>
        /// <param name="mess">消息</param>
        /// <returns>发送是否完成</returns>
        public void SendMailWeb(System.Web.Mail.MailMessage mailmsg)
        {

            //sender here
            mailmsg.From = accountName;
            // certify needed 
            mailmsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");//1 is to certify
            //the user id  
            mailmsg.Fields.Add(
                "http://schemas.microsoft.com/cdo/configuration/sendusername",
                accountName);
            //the password
            mailmsg.Fields.Add(
                "http://schemas.microsoft.com/cdo/configuration/sendpassword",
                 _password);

            System.Web.Mail.SmtpMail.SmtpServer = _smtpServer;
            try
            {
                System.Web.Mail.SmtpMail.Send(mailmsg);
            }
            catch (Exception ee)
            {
                System.Console.WriteLine(ee.Message);
            }
        }

        public bool used { set; get; }//是否在使用

        #region send mail2
        /// <summary>
        /// 发送邮件
        /// </summary>
        /// <param name="mess">JMail message消息</param>
        /// <returns>发送是否完成</returns>
        public bool SendMail(Message message)
        {
            // add an attachment
            //message.Attachments.Add( "C:\\me_dancing.wmv" );

            string domain = accountName.Split('@')[1];
            //send the message
            try
            {
                message.Charset = Encoding.UTF8;
                Smtp.Send(message, _smtpServer, (short)_smtpPort, domain, SmtpAuthentication.Login, accountName, _password);
                Console.WriteLine("The message" + message .Subject+ " has been sent，发送时间："+DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to send message {0}: 错误：{1}", message.Subject,ex.Message);
                return false;
            }
        }
        #endregion
    }
}
