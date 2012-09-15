using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
   public class QA
    {
       public int id { get; set; }
       public string username { get; set; }//提问人 或者回答人
       public string createip { get; set; }//提问 回答 IP 
       public DateTime pubdate { get; set; }//发布时间
       public string title { get; set; }//问题标题
       public string descr { get; set; }//问题内容
       public int qid { get; set; }//答案所属问题id
       public int status { get; set; }//状态
       public QA questionentity { get; set; }//问题
       public List<QA> answerslist { get; set; }//答案列表
    }
}
