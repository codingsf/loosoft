using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
  public  class EmailConnectionPool
    {
        //监控邮件发送的服务器
        static string emailServername = ConfigurationSettings.AppSettings["email.servername"] == null ? "mail.solarinfobank.com" : ConfigurationSettings.AppSettings["email.servername"];
        //监控邮件发送的服务器端口
        static int emailServerport = int.Parse(ConfigurationSettings.AppSettings["email.serverport"] == null ? "25" : ConfigurationSettings.AppSettings["email.serverport"]);
        //监控邮件发送的服务器开通的多个账号，之间用逗号分隔，以便单个邮箱账号被视为垃圾邮件
        static string emailUsername = ConfigurationSettings.AppSettings["email.username"] == null ? "service@solarinfobank.com" : ConfigurationSettings.AppSettings["email.username"];
        //监控邮件发送的服务器开通的多个账号密码，之间用逗号分隔，以便单个邮箱账号被视为垃圾邮件
        static string emailPassword = ConfigurationSettings.AppSettings["email.password"] == null ? "111111" : ConfigurationSettings.AppSettings["email.password"];
 
        private static IList<MailServerPoolObject> poolList = new List<MailServerPoolObject>();
        public EmailConnectionPool()
        {
        }
        /// <summary>
        /// 从默认配置文件项初始化邮件池
        /// </summary>
        public static void initDefaultConfiguePool()
        {
            initPool(emailUsername, emailPassword, emailServername, emailServerport);
        }
        public static void initPool(string emailNames, string emailPwds, string serverName, int port )
        {
            MailServerPoolObject mailServerPoolObject = null;
            string[] emailNameArr = emailNames.Split(',');
            string[] emailPwdArr = emailPwds.Split(',');
            string emailName = "";
            string emailPwd = "";
            for(int i=0;i<emailNameArr.Length;i++)
            {
                emailName = emailNameArr[i];
                emailPwd = emailPwdArr[i];
                mailServerPoolObject = new MailServerPoolObject(emailName, emailPwd, serverName, port);
                poolList.Add(mailServerPoolObject);
            }
        }

        /**
         * 
         * 从服务池中取得可用服务
         * @since  2010-10-14
         * @author houbing.qian
         * @return
         */
        public static MailServerPoolObject getMailServerPoolObject(){
            if (poolList == null || poolList.Count < 1)
                initDefaultConfiguePool();

            foreach(MailServerPoolObject mailServerPoolObject in poolList){
                if(mailServerPoolObject.isValid()){
                    mailServerPoolObject.used = true;
                    return mailServerPoolObject;
                }
            }
            Console.WriteLine("mail server pool has been exusted");
            return null;
        }
    }
}
