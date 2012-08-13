using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{

    public class ValidateCodeUtil
    {
        static string iscreatevalidatecode = System.Configuration.ConfigurationSettings.AppSettings["iscreatevalidatecode"] == null ? "false" : System.Configuration.ConfigurationSettings.AppSettings["iscreatevalidatecode"].ToLower();

        public static string CreateValidateCode(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string chkCode = string.Empty;
            //颜色列表，用于验证码、噪线、噪点
            Color[] color = { Color.Black, Color.Red, Color.Blue, Color.Green, Color.Orange, Color.Brown, Color.Brown, Color.DarkBlue };
            //字体列表，用于验证码
            string[] font = { "Times New Roman", "MS Mincho", "Book Antiqua", "Gungsuh", "PMingLiU", "Impact" };
            //验证码的字符集，去掉了一些容易混淆的字符
            char[] character = { '2', '3', '4', '5', '6', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'R', 'S', 'T', 'W', 'X', 'Y', 'a', 'd', 'f', 'e', 'g', 'c', 'h', 'i', 'j', 'k', 'm', 'n', 'p', 'r', 'z', 's', 't', 'u', 'v' };
            Random rnd = new Random();
            //生成验证码字符串
            for (int i = 0; i < 4; i++)
            {
                chkCode += character[rnd.Next(character.Length)];
            }
            Bitmap bmp = new Bitmap(80, 30);
            Graphics g = Graphics.FromImage(bmp);
            g.Clear(Color.White);
            //画噪线
            for (int i = 0; i < 10; i++)
            {
                int x1 = rnd.Next(80);
                int y1 = rnd.Next(30);
                int x2 = rnd.Next(80);
                int y2 = rnd.Next(30);
                Color clr = color[rnd.Next(color.Length)];
                g.DrawLine(new Pen(clr), x1, y1, x2, y2);
            }
            //画验证码字符串
            for (int i = 0; i < chkCode.Length; i++)
            {
                string fnt = font[rnd.Next(font.Length)];
                System.Drawing.Font ft = new Font(fnt, 18);
                Color clr = color[rnd.Next(color.Length)];
                g.DrawString(chkCode[i].ToString(), ft, new SolidBrush(clr), (float)i * 18 + 4, (float)4);
            }
            //画噪点
            for (int i = 0; i < 80; i++)
            {
                int x = rnd.Next(bmp.Width);
                int y = rnd.Next(bmp.Height);
                Color clr = color[rnd.Next(color.Length)];
                bmp.SetPixel(x, y, clr);
            }
            //清除该页输出缓存，设置该页无缓存
            context.Response.Buffer = true;
            context.Response.ExpiresAbsolute = System.DateTime.Now.AddMilliseconds(0);
            context.Response.Expires = 0;
            context.Response.CacheControl = "no-cache";
            context.Response.AppendHeader("Pragma", "No-Cache");
            //将验证码图片写入内存流，并将其以 "image/Png" 格式输出
            MemoryStream ms = new MemoryStream();
            try
            {
                bmp.Save(ms, ImageFormat.Png);
                context.Response.ClearContent();
                context.Response.ContentType = "image/Png";
                context.Response.BinaryWrite(ms.ToArray());

            }
            finally
            {
                //显式释放资源
                bmp.Dispose();
                g.Dispose();
            }
            context.Session[ComConst.validatecode] = chkCode;
            return chkCode;
        }

        public static bool Validated(string inputCode)
        {
            if (iscreatevalidatecode.Equals("false"))
                return true;
            if (HttpContext.Current.Session[ComConst.validatecode] == null)
                return false;
            return HttpContext.Current.Session[ComConst.validatecode].ToString().ToLower().Equals(inputCode.ToLower());
        }
    }
}
