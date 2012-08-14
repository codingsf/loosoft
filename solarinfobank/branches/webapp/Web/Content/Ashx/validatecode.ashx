<%@ WebHandler Language="C#" Class="Upload" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Web.SessionState;
using Cn.Loosoft.Zhisou.SunPower.Common;
public class Upload : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
      string chkcode=  ValidateCodeUtil.CreateValidateCode(context);
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}