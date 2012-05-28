
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    public class RequestUtil
    {
        /// <summary>
        /// 取得主域名，剔除www部分
        /// </summary>
        /// <param name="host"></param>
        /// <returns></returns>
        public static string getMainDomain(string host) {
            if (host.StartsWith("www"))
            {
                return host.Substring(host.IndexOf(".") + 1);
            }
            else {
                return host;
            }
        } 
    }
}
