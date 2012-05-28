using System.Globalization;
using System.Threading;
public static class LanguageUtil
{
    /// <summary>
    /// 从resources资源包中按照key取得资源描述
    /// </summary>
    /// <param name="langkey"></param>
    /// <returns>无值返回空串</returns>
    public static string getDesc(string langkey) {
        return getDesc(langkey, "");
    }

    /// <summary>
    /// 取得语言
    /// </summary>
    /// <param name="langkey"></param>
    /// <param name="curwebdir">资源包路径</param>
    /// <returns></returns>
    public static string getDesc(string langkey,string curwebdir)
    {
        if(curwebdir.Equals(""))
        try
        {
            curwebdir = System.Web.HttpContext.Current.Server.MapPath("/App_GlobalResources/");
        }
        catch
        {
            curwebdir = System.Environment.CurrentDirectory;
        }
        System.Resources.ResourceManager resourceManager = System.Resources.ResourceManager.CreateFileBasedResourceManager("suninforesource", curwebdir, null);
        CultureInfo ci = Thread.CurrentThread.CurrentCulture;
        string res = resourceManager.GetString(langkey, ci);
        return res == null ? "" : res;
    }
}