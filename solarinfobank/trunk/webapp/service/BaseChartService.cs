using System;
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
    public class BaseChartService : BaseService
    {
        private static BaseChartService _instance = new BaseChartService();


        public BaseChartService()
        {

        }
        /// <summary>
        /// 格式化月份数组
        /// </summary>
        /// <param name="mms"></param>
        /// <returns></returns>
        public string[] getMMX(string year)
        {
            return new string[] { year + "01", year + "02", year + "03", year + "04", year + "05", year + "06", year + "07", year + "08", year + "09", year + "10", year + "11", year + "12" };
        }

        /// <summary>
        /// 根据起始年月取得横坐标
        /// </summary>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        public IList<String> getXseriesFromYYYYMM(String startYearMM, string endYearMM)
        {
            int startMM = int.Parse(startYearMM.Substring(4, 2));
            int endMM = int.Parse(endYearMM.Substring(4, 2));
            int startYYYY = int.Parse(startYearMM.Substring(0, 4));
            int endYYYY = int.Parse(endYearMM.Substring(0, 4));
            IList<string> resList = new List<string>();

            for (int i = startYYYY; i <= endYYYY; i++)
            {
                for (int k = 1; k <= 12; k++)
                {
                    if ((i == startYYYY && k < startMM) || (i == endYYYY && k > endMM))
                    {
                        continue;
                    }
                    resList.Add(i + TableUtil.convertIntToMnthStr(k));
                }
            }
            return resList;
        }

        /// <summary>
        /// 根据起始年月天取得横坐标
        /// </summary>
        /// <param name="startYearMMDD"></param>
        /// <param name="endYearMMDD"></param>
        /// <returns></returns>
        public IList<String> getXseriesFromYYYYMMDD(string startYearMMDD, string endYearMMDD)
        {
            int startMM = int.Parse(startYearMMDD.Substring(4, 2));
            int endMM = int.Parse(endYearMMDD.Substring(4, 2));

            int startDD = int.Parse(startYearMMDD.Substring(6, 2));
            int endDD = int.Parse(endYearMMDD.Substring(6, 2));

            int startYYYY = int.Parse(startYearMMDD.Substring(0, 4));
            int endYYYY = int.Parse(endYearMMDD.Substring(0, 4));

            IList<string> resList = new List<string>();

            for (int i = startYYYY; i <= endYYYY; i++)
            {
                for (int k = 1; k <= 12; k++)
                {
                    if ((i == startYYYY && k < startMM) || (i == endYYYY && k > endMM))
                    {
                        continue;
                    }
                    int monthDay = CalenderUtil.getMonthDays(i, k);
                    for (int n = 1; n <= monthDay; n++)
                    {
                        if ((k == startMM && n < startDD) || (k == endMM && n > endDD))
                        {
                            continue;
                        }
                        resList.Add(i + TableUtil.convertIntToMnthStr(k) + TableUtil.convertIntToMnthStr(n));
                    }

                }
            }
            return resList;
        }

        /// <summary>
        /// 根据起始年月天小时取得横坐标
        /// </summary>
        /// <param name="startYearMMDDHH"></param>
        /// <param name="endYearMMDDHH"></param>
        /// <returns>天小时列表</returns>
        public IList<String> getXseriesFromYYYYMMDDHH(String startYearMMDDHH, string endYearMMDDHH, int intervalMins)
        {
            int startMM = int.Parse(startYearMMDDHH.Substring(4, 2));
            int endMM = int.Parse(endYearMMDDHH.Substring(4, 2));

            int startDD = int.Parse(startYearMMDDHH.Substring(6, 2));
            int endDD = int.Parse(endYearMMDDHH.Substring(6, 2));

            int startHH = int.Parse(startYearMMDDHH.Substring(8, 2));
            int endHH = int.Parse(endYearMMDDHH.Substring(8, 2));

            int startYYYY = int.Parse(startYearMMDDHH.Substring(0, 4));
            int endYYYY = int.Parse(endYearMMDDHH.Substring(0, 4));
            IList<string> resList = new List<string>();

            for (int i = startYYYY; i <= endYYYY; i++)
            {
                for (int k = 1; k <= 12; k++)
                {
                    if ((i == startYYYY && k < startMM) || (i == endYYYY && k > endMM))
                    {
                        continue;
                    }

                    for (int n = 1; n <= CalenderUtil.getMonthDays(i, k); n++)
                    {
                        if ((k == startMM && n < startDD) || (k == endMM && n > endDD))
                        {
                            continue;
                        }
                        for (int m = 0; m <= 23; m++)
                        {
                            //add by qianhb in 2011/12/17 去掉日中的4点之前和212点之后的
                            if (m > 22 || m < 4) continue;
                            //add by qianhb in 2011/12/17 去掉日中的4点之前和22点之后的 end
                            if ((n == startDD && m < startHH) || (n == endDD && m > endHH))
                            {
                                continue;
                            }
                            if (intervalMins >= 60)
                            {
                                resList.Add(n.ToString("00") + m.ToString("00") + "00");
                            }
                            else
                            {
                                for (int z = 0; z < 60; z = z + intervalMins)
                                {
                                    resList.Add(n.ToString("00") + m.ToString("00") + z.ToString("00"));
                                }
                            }
                        }
                    }
                }
            }
            return resList;
        }

        /// <summary>
        /// 截取实际x轴坐标
        /// </summary>
        /// <param name="ic"></param>
        /// <param name="startYearMM"></param>
        /// <param name="endYearMM"></param>
        /// <returns></returns>
        protected string[] cutXAxisData(string[] ic, string start, string end)
        {
            ICollection<string> res = new List<string>();
            foreach (string xdata in ic)
            {
                if (int.Parse(xdata) >= int.Parse(start) && int.Parse(xdata) <= int.Parse(end))
                {
                    res.Add(xdata);
                }
            }
            return res.ToArray();
        }

        /// <summary>
        /// 根据图表时间类型，格式化x轴坐标
        /// </summary>
        /// <param name="arrx"></param>
        /// <param name="chartTimeType"></param>
        /// <returns></returns>
        public string[] formatXaxis(string[] arrx, int chartTimeType)
        {
            switch (chartTimeType)
            {
                case ChartTimeType.Hour:
                    return formatHHX(arrx);
                case ChartTimeType.Day:
                    return formatHHDay(arrx);
                case ChartTimeType.YearMonthDay:
                    return formatYearMMDDX(arrx);
                case ChartTimeType.YearMonth:
                    return formatYearMMX(arrx);
                case ChartTimeType.Month:
                    return formatMMX(arrx);
                case ChartTimeType.MonthDay:
                    return formatMMDDX(arrx);
                case ChartTimeType.MonthDayWithMonth:
                    return formatMMDDXWithMonth(arrx);
                case ChartTimeType.Week:
                    return formatWeekFromDay(arrx);
                default:
                    return arrx;
            }
        }

        /// <summary>
        /// 格式化月份
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns></returns>
        private string[] formatMMX(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                newArr[i] = LanguageUtil.getDesc("MONTH_" + int.Parse(tmp));
            }
            return newArr;
        }
        /// <summary>
        /// 格式化周
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns></returns>
        private string[] formatWeekFromDay(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                int year = int.Parse(tmp.Substring(0, 4));
                int mm = int.Parse(tmp.Substring(4, 2));
                int dd = int.Parse(tmp.Substring(6, 2));
                //int week = Convert.ToInt32((new DateTime(year,mm,dd)).DayOfWeek);//今天星期几
                //switch(week){
                //    case 0:
                //        newArr[i] = LanguageUtil.getDesc("MONDAY");
                //        break;
                //    case 1:
                //        newArr[i] = LanguageUtil.getDesc("THURSDAY");
                //        break;
                //    case 2:
                //        newArr[i] = LanguageUtil.getDesc("WEDNESDAY");
                //        break;
                //    case 3:
                //        newArr[i] = LanguageUtil.getDesc("THURSDAY");
                //        break;
                //    case 4:
                //        newArr[i] = LanguageUtil.getDesc("FRIDAY");
                //        break;
                //    case 5:
                //        newArr[i] = LanguageUtil.getDesc("SATURDAY");
                //        break;
                //    case 6:
                //        newArr[i] = LanguageUtil.getDesc("SUNDAY");
                //        break;
                //}
                newArr[i] = year + "-" + mm + "-" + dd;
            }
            return newArr;
        }

        /// <summary>
        /// 格式化年月
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns></returns>
        private string[] formatYearMMX(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string year = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                newArr[i] = LanguageUtil.getDesc("MONTH_" + int.Parse(mm));
            }
            return newArr;
        }

        /// <summary>
        /// 格式月天坐标太年
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns>年月日</returns>
        private string[] formatYearMMDDX(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string year = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                string dd = tmp.Substring(6, 2);
                newArr[i] = year + "/" + mm + "/" + dd;
            }
            return newArr;
        }

        /// <summary>
        /// 格式月天坐标
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns>年月日</returns>
        private string[] formatMMDDX(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string year = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                string dd = tmp.Substring(6, 2);
                newArr[i] = dd;
            }
            return newArr;
        }

        /// <summary>
        /// 格式月天坐标
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns>年月日</returns>
        private string[] formatMMDDXWithMonth(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string year = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                string dd = tmp.Substring(6, 2);
                newArr[i] = int.Parse(mm) + "/" + int.Parse(dd);
            }
            return newArr;
        }

        /// <summary>
        /// 格式化天小时坐标
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns>dd HH:mm:ss</returns>
        private string[] formatHHX(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string dd = tmp.Substring(0, 2);
                string hh = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                newArr[i] = hh + ":" + mm;
            }
            return newArr;
        }


        /// <summary>
        /// 格式化天小时坐标
        /// </summary>
        /// <param name="arrx"></param>
        /// <returns>dd HH:mm:ss</returns>
        private string[] formatHHDay(string[] arrx)
        {
            string[] newArr = new string[arrx.Length];
            for (int i = 0; i < arrx.Length; i++)
            {
                string tmp = arrx[i];
                string dd = tmp.Substring(0, 2);
                string hh = tmp.Substring(2, 2);
                string mm = tmp.Substring(4, 2);
                newArr[i] = hh + ":" + mm + "/" + dd;
            }
            return newArr;
        }

        /// <summary>
        /// 合并结果数组
        /// </summary>
        /// <param name="oArr"></param>
        /// <param name="newArr"></param>
        protected float?[] mergeHash(float?[] oArr, float?[] newArr)
        {
            if (oArr.Length == newArr.Length)
            {
                for (int i = 0; i < oArr.Length; i++)
                {
                    if (oArr[i] != null && newArr[i] != null)
                        oArr[i] = (float?)Math.Round(double.Parse((oArr[i] + newArr[i]).ToString()), 2);
                }
            }
            return oArr;
        }

        /// <summary>
        /// 将数据按照坐标再加工，没有的添加null
        /// </summary>
        /// <param name="name"></param>
        /// <param name="ic"></param>
        /// <param name="dataHash"></param>
        /// <param name="rate"></param>
        /// <returns></returns>
        protected KeyValuePair<string, float?[]> GenerateChartData(string name, IList<string> ic, Hashtable dataHash, float rate)
        {
            //封装报表信息
            float?[] datas = new float?[ic.Count];
            for (int i = 0; i < ic.Count; i++)
            {
                object obj = dataHash[ic[i]];
                if (obj == null)
                {
                    datas[i] = null;
                }
                else
                {
                    datas[i] = (float)Math.Round(double.Parse(obj.ToString()) * rate, 2);

                    if (rate != 1.0 && datas[i] > 1.1 && ic.Count == 24) datas[i] = null;//对于做kwh/kwp的值大于1.1的日数据抛弃，这个用坐标是24和rate=1判断不严谨，如果日坐标变了就会有问题。暂时这么处理
                }
            }
            return new KeyValuePair<string, float?[]>(name, datas);
        }



        /// <summary>
        /// 取得CO2减排换算率
        /// </summary>
        /// <returns></returns>
        protected float getCO2Rate()
        {

            ItemConfig modcon = ItemConfigService.GetInstance().GetItemConfigByName(ItemConfig.CO2);
            if (modcon == null)
            {
                return 1F;
            }
            else
            {
                return modcon.value;
            }
        }

        /// <summary>
        /// 
        /// 链接x坐标
        /// </summary>
        /// <param name="keys"></param>
        /// <returns></returns>
        protected string[] joinXSeries(ICollection<ICollection> keys)
        {
            ICollection<string> xSeries = new HashSet<string>();
            foreach (ICollection ic in keys)
            {
                foreach (string key in ic)
                {
                    xSeries.Add(key);
                }
            }
            return xSeries.ToArray();
        }


        /// <summary>
        /// 更加电站集合取得有增量环境监测仪设备列表
        /// </summary>
        /// <param name="plantList"></param>
        /// <returns></returns>
        protected IList<Device> getDevicesByPlantsWithSunshine(IList<Plant> plantList)
        {
            IList<Device> devices = new List<Device>();
            Device device;
            foreach (Plant plant in plantList)
            {
                device = plant.getDetectorWithRenderSunshine();
                if (device != null) devices.Add(device);
            }
            return devices;
        }

        /// <summary>
        /// 得到理论发电量换算率
        /// </summary>
        /// <param name="designPower"></param>
        /// <returns></returns>
        protected float getEnergyRate(float designPower)
        {
            return 1.0F / 1000 * designPower; ;
        }


        /// <summary>
        /// 取得多个电站的每个理论发电换算率
        //. 计算理论发电量=（日辐射量）/1000*设计功率
        /// </summary>
        /// <param name="plantList"></param>
        /// <returns></returns>
        protected IList<float> getDeviceRatesByPlantsWithSunshine(IList<Plant> plantList)
        {
            IList<float> rates = new List<float>();
            float rate;
            foreach (Plant plant in plantList)
            {
                rate = getEnergyRate(plant.design_power);
                rates.Add(rate);
            }
            return rates;
        }

        protected float?[] computeByType(string[] ic, IList<KeyValuePair<string, float?[]>> datas, int computeType)
        {
            switch (computeType)
            {
                case ComputeType.Avg:
                    return computeAvg(ic, datas);

                case ComputeType.Ratio:
                    return computeRatio(ic, datas);
                default:
                    return null;
            }
        }
        /// <summary>
        /// 计算多维值的均值
        /// </summary>
        /// <param name="datas"></param>
        /// <returns></returns>
        protected float?[] computeAvg(string[] ic, IList<KeyValuePair<string, float?[]>> datas)
        {
            float?[] newdatas = new float?[ic.Length];
            float?[] newdatalengths = new float?[ic.Length];
            float?[] tmpdatas = null;
            KeyValuePair<string, float?[]> data = new KeyValuePair<string, float?[]>();
            for (int k = 0; k < datas.Count; k++)
            {
                data = datas[k];
                tmpdatas = data.Value;
                for (int i = 0; i < tmpdatas.Length; i++)
                {
                    float? obj = tmpdatas[i];
                    if (obj != null)
                    {
                        newdatas[i] = obj + (newdatas[i] == null ? 0 : newdatas[i]);
                        newdatalengths[i] = (newdatalengths[i] == null ? 1 : (newdatalengths[i] + 1));
                    }
                }
            }
            //最后计算一个均值
            for (int i = 0; i < newdatas.Length; i++)
            {
                float? obj = newdatas[i];
                if (obj != null)
                {
                    newdatas[i] = (float)Math.Round(double.Parse((newdatas[i] / newdatalengths[i]).ToString()), 2);
                }
            }
            return newdatas;
        }

        /// <summary>
        /// 计算多维值的比值
        /// </summary>
        /// <param name="datas"></param>
        /// <returns></returns>
        protected float?[] computeRatio(string[] ic, IList<KeyValuePair<string, float?[]>> datas)
        {
            float?[] newdatas = new float?[ic.Length];
            if (datas.Count != 2) return new float?[ic.Length];
            float?[] tmpdata1 = datas[0].Value;
            float?[] tmpdata2 = datas[1].Value;
            if (tmpdata1 == null) return newdatas;

            for (int i = 0; i < tmpdata1.Length; i++)
            {
                float? obj = tmpdata1[i];
                float? obj2 = tmpdata2[i];
                if (obj != null)
                {
                    newdatas[i] = (obj2 == null ? null : (float?)Math.Round(double.Parse((obj/obj2).ToString()), 2));
                }
            }
 
            return newdatas;
        }
    }
}