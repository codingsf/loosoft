using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{
    public class QA
    {
        public const int NORMAL = 0;
        public const int VALIDATE = 1;
        public const int NOVALIDATE = 2;

        public int id { get; set; }
        public string username { get; set; }//提问人 或者回答人
        public string createip { get; set; }//提问 回答 IP 
        public DateTime pubdate { get; set; }//发布时间
        public string title { get; set; }//问题标题
        public string descr { get; set; }//问题内容
        public int qid { get; set; }//答案所属问题id
        public int status { get; set; }//状态
        public QA questionentity { get; set; }//问题
        public IList<QA> answerslist { get; set; }//答案列表
        public bool isRecommend { get; set; }//是否推荐到首页


        /// <summary>
        /// 是否有回答
        /// </summary>
        public bool isanswered
        {
            get
            {
                return (this.answerslist != null && this.answerslist.Count > 0);
            }
        }

        /// <summary>
        /// 回答人
        /// </summary>
        public string answerUserName
        {
            get
            {
                if (this.answerslist != null && this.answerslist.Count > 0)
                    return answerslist[0].username;
                return string.Empty;
            }    
        }
    }
}
