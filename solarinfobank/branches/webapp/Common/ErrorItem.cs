using System.Collections.Generic;
using System.Threading;
namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 告警错误类型
    /// </summary>
    public class ErrorItem
    {
        /// <summary>
        /// 运行 0x0000
        /// </summary>
        public const int error_run = 0;
        /// <summary>
        /// 直流过压 0x0001
        /// </summary>
        public const int error_zlgy = 1;
        /// <summary>
        /// 电网过压 0x0008
        /// </summary>
        public const int error_dwgy = 8;
        /// <summary>
        /// 电网欠压	0x0010
        /// </summary>
        public const int error_dyqy = 16;
        /// <summary>
        /// 变压器过温	0x0020
        /// </summary>
        public const int error_byqgw = 32;
        /// <summary>
        /// 频率异常（保留）	0x0040
        /// </summary>
        public const int error_plych = 64;
        /// <summary>
        /// 孤岛故障	0x0080
        /// </summary>
        public const int error_gudgzh = 128;
        /// <summary>
        /// 硬件故障	0x0200
        /// </summary>
        public const int error_yjgzh = 512;
        /// <summary>
        /// 接地故障	0x0400
        /// </summary>
        public const int error_jdgzh = 1024;
        /// <summary>
        /// 模块故障	0x0800
        /// </summary>
        public const int error_mkgzh = 2048;
        /// <summary>
        /// 接触器故障	0x4000
        /// </summary>
        public const int error_jchqgzh = 16384;
        /// <summary>
        /// 停机	0x8000
        /// </summary>
        public const int error_tingji = 32768;
        /// <summary>
        /// 初始待机	0x1200
        /// </summary>
        public const int error_chshidj = 4608;
        /// <summary>
        /// 按键关机	0x1300
        /// </summary>
        public const int error_ajgj = 4864;
        /// <summary>
        /// 待机	0x1400
        /// </summary>
        public const int error_daiji = 5120;
        /// <summary>
        /// 紧急停机	0x1500
        /// </summary>
        public const int error_jjtj = 5376;
        /// <summary>
        /// 启动中	0x1600
        /// </summary>
        public const int error_startuping = 5632;
        /// <summary>
        /// 电网过频	0x1700
        /// </summary>
        public const int error_dygp = 5888;
        /// <summary>
        /// 电网欠频	0x1800
        /// </summary>
        public const int error_dyqp = 6144;
        /// <summary>
        /// 直流母线过压	0x2300
        /// </summary>
        public const int error_zlmxgy = 8960;
        /// <summary>
        /// 直流母线欠压	0x2400
        /// </summary>
        public const int error_zlmxqy = 9216;

        /// <summary>
        /// 通讯异常	0X2500 
        /// </summary>
        public const int error_comerror = 9472;

        /// <summary>
        /// 逆变过压	0x2700
        /// </summary>
        public const int error_nbgy = 9984;
        /// <summary>
        /// 输出过载	0x2800
        /// </summary>
        public const int error_shchgzh = 10240;
        /// <summary>
        /// 蓄电池过压	0x2900
        /// </summary>
        public const int error_xdchgy = 10496;
        /// <summary>
        /// 蓄电池欠压	0x3000
        /// </summary>
        public const int error_xdchqy = 12288;
        /// <summary>
        /// 接触器吸合	0x5000
        /// </summary>
        public const int error_jcqxh = 20480;
        /// <summary>
        /// 接触器断开	0x5100
        /// </summary>
        public const int error_jcqdk = 20736;
        /// <summary>
        /// 关机中	0x5200
        /// </summary>
        public const int error_shutdowning = 20992;
        /// <summary>
        /// 直流脱扣	0x5300
        /// </summary>
        public const int error_zltk = 21248;
        /// <summary>
        /// 交流脱扣	0x5400
        /// </summary>
        public const int error_jltk = 21504;
        /// <summary>
        /// 故障停机	0x5500
        /// </summary>
        public const int error_fault = 21760;

        ///
        /// 模块过温	0x4010
        /// 
        public const int error_mkgw = 16400;

        ///
        /// GFDI故障	0x4011
        /// 
        public const int error_gfdigz = 16401;
        ///
        /// 绝缘阻抗	0x4012
        ///
        public const int error_jyzk = 16402;
        ///
        /// 休眠	0x4013
        /// 
        public const int error_xiumian = 16403;
        ///
        /// 直流熔断器故障	0x4014
        /// 
        public const int error_zlrdqgz = 16404;
        ///
        /// 电抗器过温	0x4015
        /// 
        public const int error_dkqgw = 16405;
        ///
        /// 风机故障	0x4016
        /// 
        public const int error_fjgz = 16406;

        ///
        /// 防雷器故障	0x4017
        /// 
        public const int error_flqgz = 16407;

        ///
        /// 降额运行	0x8100
        /// 
        public const int error_jerun = 33024;
        
        ///
        /// 调度运行	0x8200
        /// 
        public const int error_ddrun = 33280;
        /// <summary>
        /// 告警运行	0x9100
        /// </summary>
        public const int error_gjrun = 37120;

        static public IDictionary<int, ErrorItem> errorItemMap = new Dictionary<int, ErrorItem>();
        static ErrorItem()
        {
            //string infocodestr = ErrorItem.error_run + "," + ErrorItem.error_ajgj + "," + ErrorItem.error_chshidj + "," + ErrorItem.error_daiji;

            errorItemMap.Add(error_run, new ErrorItem() { code = error_run, errorType = ErrorType.ERROR_TYPE_INFORMATRION });
            errorItemMap.Add(error_ajgj, new ErrorItem() { code = error_ajgj, errorType = ErrorType.ERROR_TYPE_INFORMATRION });
            errorItemMap.Add(error_chshidj, new ErrorItem() { code = error_chshidj, errorType = ErrorType.ERROR_TYPE_INFORMATRION });
            errorItemMap.Add(error_daiji, new ErrorItem() { code = error_daiji, errorType = ErrorType.ERROR_TYPE_INFORMATRION });

            //string warncodestr = ErrorItem.error_byqgw + "," + ErrorItem.error_dwgy + "," + ErrorItem.error_dygp + "," + ErrorItem.error_dyqp + "," + ErrorItem.error_dyqy + "," + ErrorItem.error_jjtj;
            errorItemMap.Add(error_byqgw, new ErrorItem() { code = error_byqgw, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_dwgy, new ErrorItem() { code = error_dwgy, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_dygp, new ErrorItem() { code = error_dygp, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_dyqp, new ErrorItem() { code = error_dyqp, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_dyqy, new ErrorItem() { code = error_dyqy, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_jjtj, new ErrorItem() { code = error_jjtj, errorType = ErrorType.ERROR_TYPE_WARN });
            errorItemMap.Add(error_zlgy, new ErrorItem() { code = error_zlgy, errorType = ErrorType.ERROR_TYPE_WARN });

            //string faultcodestr = ErrorItem.error_fault + "," + ErrorItem.error_gudgzh + "," + ErrorItem.error_jchqgzh + "," + ErrorItem.error_jdgzh + "," + ErrorItem.error_mkgzh + "," + ErrorItem.error_yjgzh;
            errorItemMap.Add(error_fault, new ErrorItem() { code = error_fault, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_gudgzh, new ErrorItem() { code = error_gudgzh, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_jchqgzh, new ErrorItem() { code = error_jchqgzh, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_jdgzh, new ErrorItem() { code = error_jdgzh, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_mkgzh, new ErrorItem() { code = error_mkgzh, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_yjgzh, new ErrorItem() { code = error_yjgzh, errorType = ErrorType.ERROR_TYPE_FAULT });

            // string errorcodestr = ErrorItem.error_zltk + "," + ErrorItem.error_plych + "," + ErrorItem.error_jltk + "," + ErrorItem.error_jcqxh + "," + ErrorItem.error_jcqdk;
            errorItemMap.Add(error_zltk, new ErrorItem() { code = error_zltk, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_plych, new ErrorItem() { code = error_plych, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_jltk, new ErrorItem() { code = error_jltk, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_jcqxh, new ErrorItem() { code = error_jcqxh, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_jcqdk, new ErrorItem() { code = error_jcqdk, errorType = ErrorType.ERROR_TYPE_FAULT });
            errorItemMap.Add(error_comerror, new ErrorItem() { code = error_comerror, errorType = ErrorType.ERROR_TYPE_FAULT });
        }

        /// <summary>
        /// 根据错误项目code取得对象
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static ErrorItem getErrotItemByCode(int code)
        {
            if (errorItemMap.ContainsKey(code))
                return errorItemMap[code];
            else
                return null;
        }

        /// <summary>
        /// 从缓存中取得同步的错误码，取不到再去本地，再取不到去默认，主要用于解析器
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public static int getErrorTypefromMemcached(int code)
        {
            //同步更新缓存
            object type = MemcachedClientSatat.getInstance().Get(CacheKeyUtil.buildErrorCode(code.ToString()));
            if (type == null)
            {
                ErrorItem et = getErrotItemByCode(code);
                if (et == null) return ErrorType.ERROR_TYPE_FAULT;
                else
                    return et.errorType;
            }
            else
            {
                try
                {
                    string str = (string)type;
                    return int.Parse(str.Substring(str.IndexOf("type_") + 5));// "type_"
                }
                catch (System.Exception e)
                {
                    return ErrorType.ERROR_TYPE_FAULT;
                }
            }
        }

        private string _name;

        public ErrorItem()
        {
        }
        public int code { get; set; }                 //类型代码
        public int errorType { get; set; }            //所属错误类型
        public string name                            //类型名称
        {
            set
            {
                this._name = value;
            }
            get
            {
                //改由从后台维护的数据的多语言取得
                return getCodeName(Thread.CurrentThread.CurrentCulture.Name);
                //return LanguageUtil.getDesc("ERRORITEM_" + this.code);
            }
        }
        /// <summary>
        /// 根据语言代码取得名称
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public string getCodeName(string code)
        {
            if (_name == null || code == null) return "";

            string[] arrayList = _name.Split(',');
            string[] keyValues;
            foreach (string array in arrayList)
            {
                keyValues = array.Split(':');
                if (keyValues[0].ToLower().Equals(code.ToLower()))
                {
                    if (string.IsNullOrEmpty(keyValues[1]))
                        return _name;
                    return keyValues[1];
                }
            }
            return _name;
        }
    }
}