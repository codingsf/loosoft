using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace Cn.Loosoft.Zhisou.Tenghu.Common
{
   public class Util
    {
       public static string GetImage(string content)
       {
           if (string.IsNullOrEmpty(content))
               return string.Empty;
           Regex regex = new Regex("<img .*? src=\"(.*?)\".*? />");
           Match match = regex.Match(content);
           GroupCollection gc = match.Groups;
           return gc[1].Value;
       }

       public static string FilterHtml(string content)
       {
           if (string.IsNullOrEmpty(content))
               return string.Empty;
           content = Regex.Replace(content, @"<script[^>]*?>.*?</script>", "",
    RegexOptions.IgnoreCase);
           //删除HTML
           content = Regex.Replace(content, @"<(.[^>]*)>", "",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"([\r\n])[\s]+", "",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"-->", "", RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"<!--.*", "", RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(quot|#34);", "\"",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(amp|#38);", "&",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(lt|#60);", "<",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(gt|#62);", ">",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(nbsp|#160);", "   ",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(iexcl|#161);", "\xa1",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(cent|#162);", "\xa2",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(pound|#163);", "\xa3",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&(copy|#169);", "\xa9",
             RegexOptions.IgnoreCase);
           content = Regex.Replace(content, @"&#(\d+);", "",
             RegexOptions.IgnoreCase);
           content.Replace("<", "");
           content.Replace(">", "");
           content.Replace("\r\n", "");
           return content;
       }

    }
}
