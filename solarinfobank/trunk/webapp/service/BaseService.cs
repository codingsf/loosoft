﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using System.Collections;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 作者：鄢睿
    /// 功能：报表业务基类
    /// 创建时间：2011年02月25日
    /// </summary>
    public abstract class BaseService
    {
        /// <summary>
        /// 缓存客户端
        /// </summary>
        protected static MemcachedClientSatat mcs = MemcachedClientSatat.getInstance();
        protected IList<PlantUnit> getUnitsByPlantList(Plant plant)
        {
            return plant.allFactUnits;
        }

        /// <summary>
        /// 取得电站列表的所有单元列表
        /// </summary>
        /// <param name="plantList"></param>
        /// <returns></returns>
        protected IList<PlantUnit> getUnitsByPlantList(IList<Plant> plantList)
        {
            IList<PlantUnit> units = new List<PlantUnit>();
            foreach (Plant plant in plantList)
            {
                IList<PlantUnit> tmpunits = plant.allFactUnits;
                if (tmpunits == null)
                    break;
                foreach (PlantUnit unit in tmpunits)
                {
                    units.Add(unit);
                }
            }
            return units;
        }

        /// <summary>
        /// 排序集合
        /// 
        /// </summary>
        /// <param name="ic"></param>
        /// <returns></returns>
        protected string[] sortCollection(ICollection ic)
        {
            string[] objArr = new string[ic.Count];
            ic.CopyTo(objArr, 0);
            Array.Sort<string>(objArr, (a, b) => { return string.Compare(a, b); });
            return objArr;
        }

        /// <summary>
        /// 取得下一个点的和前一个的差的均值，用于平滑曲线，待改进大跨度的
        /// </summary>
        /// <param name="lastValue"></param>
        /// <param name="XAxis"></param>
        /// <param name="i"></param>
        /// <param name="dataHash"></param>
        /// <returns></returns>
        protected int getNextValueX(IList<string> XAxis, int i, Hashtable dataHash)
        {
            string key = "";
            object value = null;
            int k = i + 1;
            int curTime = int.Parse(XAxis[i].Substring(2,4));

            while (k < XAxis.Count)
            {
                key = XAxis[k];
                value = dataHash[key];
                if (value == null)
                {
                    k++;
                    continue;
                }
                else
                {
                    break;
                }
            }
            if (value == null) return 0;

            return k;
        }

        /// <summary>
        /// 计算平均值
        /// </summary>
        /// <param name="newValue"></param>
        /// <param name="lastValue"></param>
        /// <param name="intervalNum"></param>
        /// <returns></returns>
        protected float? computAvg(float newValue, float lastValue, int intervalNum)
        {
            //计算和后一个值的均值
            float cha = 0;
            if (lastValue > newValue)
            {
                cha = lastValue - newValue;
            }
            else
            {
                cha = newValue - lastValue;
            }
            float avg = cha / intervalNum;

            return avg;
        }
        /// <summary>
        /// 将时间面数据按照固定间隔的坐标点整理合并数据
        /// </summary>
        /// <param name="hhpowerHash"></param>
        /// <param name="daydatas"></param>
        /// <param name="intervalMins">时间间隔，有间隔必须传，如果不用按照固定间隔坐标点整理数据</param>
        /// <param name="monitorCode"></param>
        protected void joinToPointData(IList<string> XAxis, Hashtable hhpowerHash, IList daydatas, int intervalMins, int monitorCode)
        {
            //存放本次解析的结果，然后再将此结果追加到大hash
            Hashtable oncerHas = new Hashtable();
            if (daydatas.Count == 0) return;
            IList<float> pointPowers = new List<float>();
            for (int i = 0; i < daydatas.Count; i++)
            {
                BaseDayData modday = (BaseDayData)daydatas[i];
                if (modday.dataContent == null) continue;
                string[] dataContentArr = modday.dataContent.Split('#');
                //循环处理多个时间点数据,从后到前解析，已避免数据重复解析后出现累加的问题，
                string datastr = "";
                IList<string> hasHandleList = new List<string>();//用于判断本次内的某个时间点的值只被处理一次。
                for (int k = dataContentArr.Length-1; k >= 0; k--)
                {
                    datastr = dataContentArr[k];
                    if (string.IsNullOrEmpty(datastr)) continue;
                    string[] dataArr = datastr.Split(':');
                    if (dataArr.Length != 2) continue;
                    string hhmmss = dataArr[0];
                    if (hasHandleList.Contains(hhmmss)) continue;//改点数据被处理过了则跳过继续处理下面的
                    string hh = hhmmss.Substring(0, 2);
                    string data = dataArr[1];
                    if (int.Parse(hh) < 4) continue;// 小于4点前的数据就抛弃了

                    string key = getKeyPoint(modday.sendDay, intervalMins, hhmmss);

                    object ovalue = oncerHas[key];
                    if (ovalue == null)
                    {
                        oncerHas[key] = data.Equals("0") ? 0 : StringUtil.stringtoFloat(data);//?为何要将0赋为null?
                    }
                    else
                    {
                        if (StringUtil.stringtoFloat(data.Trim()) > StringUtil.stringtoFloat(ovalue.ToString().Trim()))
                            oncerHas[key] = StringUtil.stringtoFloat(data);
                    }
                }
            }
            if (XAxis!=null)
                //平滑后再累加，解决兼容不同采集器发送不同时间间隔的数据
                FirstHandleChartData(XAxis, oncerHas);

            //再将本次一个采集器的解析结果累计到多个采集器集合中
            string[] sortKeys = sortCollection(oncerHas.Keys);
            object preValue = null;
            object curValue = null;
            foreach (object key in sortKeys)
            {
                object ovalue = hhpowerHash[key];
                curValue = oncerHas[key];
                //计算差值
                if (monitorCode == MonitorType.PLANT_MONITORITEM_ENERGY_CODE || (monitorCode == MonitorType.MIC_INVERTER_TODAYENERGY && intervalMins > 30))
                {
                    if (preValue != null)
                    {
                        if (curValue != null)
                        {
                            float cha = StringUtil.stringtoFloat(curValue.ToString()) - StringUtil.stringtoFloat(preValue.ToString());
                            if (cha >= 0)
                            {
                                preValue = curValue;
                                curValue = cha;
                            }
                            else
                                curValue = null;
                        }
                    }
                    else
                        preValue = curValue;
                }
                if (ovalue == null)
                {
                    hhpowerHash[key] = curValue;
                }
                else
                {
                    float newValue = StringUtil.stringtoFloat(ovalue.ToString()) + (curValue == null ? 0 : StringUtil.stringtoFloat(curValue.ToString()));
                    hhpowerHash[key] = newValue;
                }
            }
        }


        /// <summary>
        /// 加工数据，包括平滑效果
        /// </summary>
        /// <param name="XAxis"></param>
        /// <param name="dataHash"></param>
        /// <param name="rate"></param>
        public void FirstHandleChartData(IList<string> XAxis, Hashtable dataHash)
        {
            //封装报表信息
            float lastValue = -1;
            int i = 0;
            while (i < XAxis.Count)
            {
                object obj = dataHash[XAxis[i]];
                if (obj == null)
                {
                    if (lastValue != -1)
                    {
                        i--;//将当前下标前置上一个非空位置
                        //取得下一个值的坐标
                        int nextX = getNextValueX(XAxis, i, dataHash);
                        if (nextX == 0)//没有下一个值
                        {
                            break;
                        }
                        else
                        {
                            //计算下载一个值的坐标跨度,超过一个小时不再处理
                            if (int.Parse(XAxis[nextX].Substring(2, 4)) - int.Parse(XAxis[i].Substring(2, 4)) < 100)
                            {
                                //当前值
                                float curValue = StringUtil.stringtoFloat(dataHash[XAxis[nextX]].ToString());
                                float? avg = computAvg(curValue, lastValue, nextX - i + 1);
                                if (curValue < lastValue) avg = avg * -1;
                                for (int n = i; n < nextX; n++)
                                {
                                    dataHash[XAxis[n]] = lastValue + avg * (n - i + 1);
                                }
                            }
                            i = nextX;
                            continue;
                        }
                    }
                }
                else
                {
                    dataHash[XAxis[i]] = obj;
                    lastValue = StringUtil.stringtoFloat(obj.ToString());
                }
                i++;
            }
        }

        /// <summary>
        /// 取得发送时间的数据规整点
        /// </summary>
        /// <param name="day"></param>
        /// <param name="intervalMins"></param>
        /// <param name="hhmmss"></param>
        /// <returns></returns>
        protected string getKeyPoint(int day, int intervalMins, string HHmmss)
        {
            string hh = HHmmss.Substring(0, 2);
            int curMins = int.Parse(HHmmss.Substring(2, 2));
            int nums = curMins / intervalMins;
            return day.ToString("00") + hh + (nums * intervalMins).ToString("00");
        }

        /// <summary>
        /// 取得发送时间的数据规整点
        /// </summary>
        /// <param name="intervalMins"></param>
        /// <param name="hhmmss"></param>
        /// <returns>HHmm</returns>
        /// <param name="mid">中间连接符</param> 
        protected string getKeyPointWithMid(int intervalMins, string HHmmss,string mid)
        {
            string hh = HHmmss.Substring(0, 2);
            int curMins = int.Parse(HHmmss.Substring(2, 2));
            int nums = curMins / intervalMins;
            return hh + mid+ (nums * intervalMins).ToString("00");
        }

        /// <summary>
        /// 将给定数据，增加天天发电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        protected void addPlantDayEnergy(Hashtable energyHash, int plantId, string startYearMMDD, string endYearMMDD)
        {
            Plant plant = PlantService.GetInstance().GetPlantInfoById(plantId);
            addPlantDayEnergy(energyHash, new List<Plant>{ plant }, startYearMMDD, endYearMMDD);
        }

        /// <summary>
        /// 将给定数据，增加天天发电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        protected void addPlantDayEnergy(Hashtable energyHash, IList<Plant> plants, string startYearMMDD, string endYearMMDD)
        {
            String year = startYearMMDD.Substring(0, 4);
            String month = startYearMMDD.Substring(4, 2);
            foreach (Plant plant in plants)
            {
                //取出该电站的该月的所有天补偿设置
                IList<Compensation> comps = CompensationService.GetInstance().getPlantDayCompensations(plant.id, year, month);
                String dayKey = "";
                foreach (Compensation comp in comps)
                {
                    dayKey = year+month + comp.day.ToString("00");
                    energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey]!=null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
                }
            }
        }

        protected void addPlantMonthEnergy(Hashtable energyHash, IList<Plant> plants, string startYearMM, string endYearMM)
        {
            foreach (Plant plant in plants)
            {
                addPlantMonthEnergy(energyHash, plant.id, startYearMM, endYearMM);
            }
        }

        /// <summary>
        /// 增加电站某年某些月份的电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        /// <param name="plant"></param>
        protected void addPlantMonthEnergy(Hashtable energyHash, int plantId, string startYearMM,string endYearMM)
        {
            String year = startYearMM.Substring(0, 4);
            //取出该电站的该月的所有天补偿设置
            IList<Compensation> comps = CompensationService.GetInstance().getPlantMonthCompensations(plantId, year);
            String dayKey = "";
            foreach (Compensation comp in comps)
            {
                dayKey = comp.year.ToString("00") + comp.month.ToString("00");
                energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey] != null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
            }
        }

        protected void addPlantYearEnergy(Hashtable energyHash, IList<Plant> plants)
        {
            foreach (Plant plant in plants) {
                addPlantYearEnergy(energyHash, plant.id);
            }
        }
        protected void addPlantYearEnergy(Hashtable energyHash, int plantId)
        {
            //取出该电站的该月的所有天补偿设置
            IList<Compensation> comps = CompensationService.GetInstance().getPlantYearCompensations(plantId);
            String dayKey = "";
            foreach (Compensation comp in comps)
            {
                dayKey = comp.year.ToString("00");
                energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey] != null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
            }
        }

        /// <summary>
        /// 将给定数据，增加设备天天发电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        protected void addDeviceDayEnergy(Hashtable energyHash, int deviceId, string startYearMMDD, string endYearMMDD)
        {
            String year = startYearMMDD.Substring(0, 4);
            String month = startYearMMDD.Substring(4, 2);
            //取出该电站的该月的所有天补偿设置
            IList<Compensation> comps = CompensationService.GetInstance().getDeviceDayCompensations(deviceId, year, month);
            String dayKey = "";
            foreach (Compensation comp in comps)
            {
                dayKey = year + month + comp.day.ToString("00");
                energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey] != null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
            }
        }

        /// <summary>
        /// 增加设备某年某些月份的电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        /// <param name="device"></param>
        protected void addDeviceMonthEnergy(Hashtable energyHash, int deviceId, string startYearMM, string endYearMM)
        {
            String year = startYearMM.Substring(0, 4);
            //取出该电站的该月的所有天补偿设置
            IList<Compensation> comps = CompensationService.GetInstance().getDeviceMonthCompensations(deviceId, year);
            String dayKey = "";
            foreach (Compensation comp in comps)
            {
                dayKey = comp.year.ToString("00") + comp.month.ToString("00");
                energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey] != null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
            }
        }

        /// <summary>
        /// 增加设备某些年度的电量补偿
        /// </summary>
        /// <param name="energyHash"></param>
        /// <param name="plant"></param>
        protected void addDeviceYearEnergy(Hashtable energyHash, int deviceId)
        {
            //取出该电站的该月的所有天补偿设置
            IList<Compensation> comps = CompensationService.GetInstance().getDeviceYearCompensations(deviceId);
            String dayKey = "";
            foreach (Compensation comp in comps)
            {
                dayKey = comp.year.ToString("00");
                energyHash[dayKey] = (energyHash.ContainsKey(dayKey) && energyHash[dayKey] != null) ? StringUtil.stringtoDouble(energyHash[dayKey].ToString()) + comp.dataValue : comp.dataValue;
            }
        }
    }
}