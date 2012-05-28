<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Cn.Loosoft.Zhisou.SunPower.Common;
public class Upload : IHttpHandler
{
    static int plant_pic_height = System.Configuration.ConfigurationSettings.AppSettings["plant_pic_height"] == null ? 60 : int.Parse(System.Configuration.ConfigurationSettings.AppSettings["plant_pic_height"]);
    static int plant_pic_width = System.Configuration.ConfigurationSettings.AppSettings["plant_pic_width"] == null ? 60 : int.Parse(System.Configuration.ConfigurationSettings.AppSettings["plant_pic_width"]);


    public void ProcessRequest(HttpContext context)
    {
        string filePath = context.Request["path"];
        Bitmap myImage = new Bitmap(filePath);
        MemoryStream ms = new MemoryStream();
        myImage.Save(ms, ImageFormat.Jpeg);
        context.Response.ClearContent();
        context.Response.ContentType = "image/Jpeg";
        context.Response.BinaryWrite(ms.ToArray());
        ms.Close();
        ms.Dispose();
        myImage.Dispose();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}