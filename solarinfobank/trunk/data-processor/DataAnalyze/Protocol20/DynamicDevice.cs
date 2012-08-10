using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using DataAnalyze;
using Protocol;
using DataAnalyze.Protocol20;
namespace Protocol20
{

    /// <summary>
    /// 通用动态设备解析类
    /// 所有2.0的设备通用
    /// </summary>
    public class DynamicDevice : DeviceDataBase
    {
        public string DevName = "通用设备装置";
        int deviceDataHeadLength = 5;//5字节
        BaseMessage message = null;
        /// <summary>
        /// 更加2.0实时数据基本码表动态解析设备实时数据
        /// </summary>
        public void analysis()
        {
            message.messageHeader.hasData = false;//设备数据是头部标识为无数据，不再处理
            //deviceData="2900010000001E3B0A1A060C050003031900000000010305190000000001010619000000000101071900000000010108190000000001";
            //地址即新协议中的公共地址 u16
            base.deviceAddress = SystemCode.HexNumberToDenary(deviceData.Substring(2 * 2, 2 * 2), true, 16, 'u').ToString();
            //设备版本
            int largeVersion = 2;// (int)SystemCode.HexNumberToDenary(deviceData.Substring(3 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u');
            int smallVersion = 0;// (int)SystemCode.HexNumberToDenary(deviceData.Substring(4 * hexbytecharnum, 1 * hexbytecharnum), true, 8, 'u');
            base.deviceVersion = largeVersion + "." + smallVersion;
            
            string infoData = deviceData.Substring(14 * 2);
            //解析多个信息体
            //每个信息体开始下标
            int startIndex = 0;
            //每个信息体结束下标
            int endIndex = 0;
            int infotype = 0;
            //逐个取出信息体
            string info;
            string[] infoResult;
            int mcode;
            base.deviceType = -1;
            while (infoData.Length > 0)
            {
                //取得不同信息单元地址对应的解析规则
                infotype = InfoBodyUtil.getInfotype(infoData);
                endIndex = InfoBodyUtil.getInfotypeLen(infotype);
                info = infoData.Substring(startIndex * 2, endIndex * 2);
                //没有数据就退出
                if (string.IsNullOrEmpty(info)) break;
                InfoUnitAddress infoUnitAddress = InfoBodyUtil.getInfoUnitAddress(info);

                //没有解析规则跳过
                if (infoUnitAddress == null)
                {
                    infoData = infoData.Substring(endIndex * 2);
                    continue;
                }
                //if (infoUnitAddress.address == 203)
                //{
                //    Console.WriteLine("");
                //}
                //解析单个信息体
                infoResult = InfoBodyUtil.analyze(info, infotype,infoUnitAddress);
                mcode = infoUnitAddress.mcode;
                if (infoResult.Length > 0)
                {
                    if(infoResult.Length>2){//是故障
                        faultList.Add(infoResult);
                    }else{
                        realMonitorMap[mcode] = infoResult[1];
                        if (MonitorType.historyMonitorList.Contains(mcode))
                        {
                            historyMonitorMap[mcode] = infoResult[1];
                        }
                        if (mcode == MonitorType.MIC_DETECTOR_SUNLINGHT)
                        {
                            //最近环境监测仪数据到header数据中
                            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = infoResult[1];
                            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_LINGT_CODE] = infoResult[1];
                            message.messageHeader.issub = true;
                        }
                        if (mcode == MonitorType.MIC_DETECTOR_ENRIONMENTTEMPRATURE)
                        {
                            //最近环境监测仪数据到header数据中
                            message.realMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = infoResult[1];
                            message.historyMonitorMap[MonitorType.PLANT_MONITORITEM_AMBIENTTEMP_CODE] = infoResult[1];
                            message.messageHeader.issub = true;
                        }
                        //记录日发电量，用于年月汇总
                        if (mcode == MonitorType.MIC_INVERTER_TODAYENERGY)
                        {
                            base.todayEnergy = double.Parse(infoResult[1]);
                        }
                        //记录日累计增量日照，用于年月汇总
                        if (mcode == MonitorType.MIC_DETECTOR_DAYRADIATION)
                        {
                            base.todaySunshine = double.Parse(infoResult[1]);
                        }
                    }
                }
                infoData = infoData.Substring(endIndex * 2);
                tableType = TableUtil.getTableNamebyDeviceType(infoUnitAddress.deviceType);
                base.deviceType = infoUnitAddress.deviceType;
            }
        }

        public DynamicDevice(string tcpcontent, BaseMessage message)
        {
            base.deviceData = tcpcontent;
            this.message = message;
            this.analysis();
        }

    }
}
