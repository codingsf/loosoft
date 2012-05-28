/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月16日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Protocol;
using Cn.Loosoft.Zhisou.SunPower.Service;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Threading;
using System.Reflection;
using System.Configuration;
namespace DataAnalyze
{
    /// <summary>
    /// 解析统计
    /// </summary>
    public class AnalyzeCount
    {
        public static int waittotal = 0;//获取的处理总数
        public static int total = 0;//处理总数
        public static int successNum = 0;//成功数
        public static int failNum = 0;//失败数
        public static int curWaittotal = 0;//获取的处理总数
        public static int curtotal = 0;//本次处理总数
        public static int curSuccessNum = 0;//本次成功数
        public static int curFailNum = 0;//本次失败数
        public static DateTime lasttime = new DateTime();//最新一笔背解析的数据的发送时间
    }
}
