<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;
using Cn.Loosoft.Zhisou.SunPower.Common;
public class Upload : IHttpHandler {
    static int plant_pic_height = System.Configuration.ConfigurationSettings.AppSettings["plant_pic_height"] == null ? 60 : int.Parse(System.Configuration.ConfigurationSettings.AppSettings["plant_pic_height"]);
    static int plant_pic_width = System.Configuration.ConfigurationSettings.AppSettings["plant_pic_width"] == null ? 60 : int.Parse(System.Configuration.ConfigurationSettings.AppSettings["plant_pic_width"]);
    
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            HttpPostedFile upload = context.Request.Files["Filedata"];
            string name = DateTime.Now.Ticks.ToString() + Path.GetExtension(upload.FileName);
            string aimpath = context.Server.MapPath("../../ufile");
            upload.SaveAs(Path.Combine(aimpath,name));
            // Determine whether the directory exists.
            

            //压缩图片为制定尺寸
            string oldPic = aimpath+"/"+name;
            string smallPic = aimpath+"/small/"+name;
            if (!Directory.Exists(aimpath + "/small/")) {
                Directory.CreateDirectory(aimpath + "/small/");
            }
            PicUtil.SmallPic(oldPic, smallPic, plant_pic_width, plant_pic_height);
            
            context.Response.StatusCode = 200;
            context.Response.Write(name);
        }
        catch(Exception ex)
        {
            context.Response.StatusCode = 200;
            context.Response.Write(ex);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}