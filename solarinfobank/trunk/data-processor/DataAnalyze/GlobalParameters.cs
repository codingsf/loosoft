/*******************************
/* 项目：数据解析模块             
/* 版本：1.0                           
/* 作者：胡圣忠                   
/* 日期：2011年2月17日           
/*******************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAnalyze
{
    public class Location {
       public  int iStart;
       public  int iCount;
    }
    /// <summary>
    /// TCP消息头
    /// </summary>
    public class TCPHeaderByteNum 
    {

        static TCPHeaderByteNum()
        {
            TCPHeaderByteNum.Version.iStart = 8*2;
            TCPHeaderByteNum.Version.iCount = 2*2;

            TCPHeaderByteNum.UnitID.iStart = 0 * 2;
            TCPHeaderByteNum.UnitID.iCount = 8*2;

            TCPHeaderByteNum.TimeNow.iStart = 10*2;
            TCPHeaderByteNum.TimeNow.iCount = 6*2;

            TCPHeaderByteNum.DevicesNum.iStart = 16*2;
            TCPHeaderByteNum.DevicesNum.iCount = 1*2;

            TCPHeaderByteNum.BugNum.iStart = 17*2;
            TCPHeaderByteNum.BugNum.iCount = 1*2;

        }
      
        /// <summary>
        /// 总长度
        /// </summary>
        public  static  int TcpHeaderByteNum=18*2;

       
        /// <summary>
        /// 版本号
        /// </summary>
        public static Location Version =new Location();
        /// <summary>
        /// 设备ID
        /// </summary>
        public static Location UnitID = new Location();
        /// <summary>
        /// 当前时间 设备所在地区时间 
        /// </summary>
         public  static  Location TimeNow =new Location();
      
        /// <summary>
        /// 设备数
        /// </summary>
         public  static  Location DevicesNum =new Location();
        /// <summary>
        /// 故障信息数
        /// </summary>
         public  static  Location BugNum =new Location();
    }


    /// <summary>
    /// TCP消息体
    /// </summary>
    public class TCPBugByteNum
    {
         static TCPBugByteNum()
        {
            TCPBugByteNum.DeviceType.iStart = 0*2;
            TCPBugByteNum.DeviceType.iCount = 2*2;
            TCPBugByteNum.DeviceId.iStart = 2*2;
            TCPBugByteNum.DeviceId.iCount = 2*2;
            TCPBugByteNum.BugType.iStart = 4*2;
            TCPBugByteNum.BugType.iCount = 2*2;


        }

        /// <summary>
        /// 总长度
        /// </summary>
        public static int TcpBugByteNum = 6*2;

        /// <summary>
        /// 设备类型
        /// </summary>
        public static Location DeviceType = new Location();
        /// <summary>
        /// 设备编号
        /// </summary>
        public static Location DeviceId = new Location();
        /// <summary>
        /// 故障类型
        /// </summary>
        public static Location BugType = new Location();
    }
}
