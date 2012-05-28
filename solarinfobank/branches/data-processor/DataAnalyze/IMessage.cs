using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace DataAnalyze
{
    /// <summary>
    /// 消息类接口
    /// </summary>
    interface IMessage
    {
        void getDeviceDayDataList();
        void GetCollectorDaydataList();
        void GetFaultList();
        void GetCollectorRunData();
        void GetDeviceRunDataList();
    }
}
