using System.Collections.Generic;

namespace Cn.Loosoft.Zhisou.SunPower.Common
{
    /// <summary>
    /// 错误类型
    /// </summary>
    public class ErrorType
    {

        //告警类型
        /// <summary>
        /// 信息
        /// </summary>
        public const int ERROR_TYPE_INFORMATRION = 0x01;
        /// <summary>
        /// 警告
        /// </summary>
        public const int ERROR_TYPE_WARN = 0x02;
        /// <summary>
        /// 故障
        /// </summary>
        public const int ERROR_TYPE_FAULT = 0x03;
        /// <summary>
        /// 错误
        /// </summary>
        public const int ERROR_TYPE_ERROR = 0x04;

        //错误类型列表
        static public IDictionary<int, ErrorType> errorTypeMap = new Dictionary<int, ErrorType>();

        static ErrorType()
        {
            string infocodestr=  ErrorItem.error_run + "," + ErrorItem.error_ajgj + "," +ErrorItem.error_chshidj+","+ErrorItem.error_daiji;
            string warncodestr = ErrorItem.error_byqgw + "," + ErrorItem.error_dwgy + "," + ErrorItem.error_dygp + "," + ErrorItem.error_dyqp + "," + ErrorItem.error_dyqy + "," + ErrorItem.error_jjtj;
            string faultcodestr = ErrorItem.error_fault + "," + ErrorItem.error_gudgzh + "," + ErrorItem.error_jchqgzh + "," + ErrorItem.error_jdgzh + "," + ErrorItem.error_mkgzh + "," + ErrorItem.error_yjgzh + "," + ErrorItem.error_zltk + "," + ErrorItem.error_plych + "," + ErrorItem.error_jltk + "," + ErrorItem.error_jcqxh + "," + ErrorItem.error_jcqdk + "," + ErrorItem.error_comerror;
            string errorcodestr = ""; 

            ErrorType info = new ErrorType() { code = ERROR_TYPE_INFORMATRION, errorItems = infocodestr };
            ErrorType warn = new ErrorType() { code = ERROR_TYPE_WARN, errorItems = warncodestr };
            ErrorType fault = new ErrorType() { code = ERROR_TYPE_FAULT, errorItems = faultcodestr };
            ErrorType error = new ErrorType() { code = ERROR_TYPE_ERROR, errorItems = errorcodestr };

            errorTypeMap.Add(ERROR_TYPE_INFORMATRION, info);
            errorTypeMap.Add(ERROR_TYPE_WARN, warn);
            errorTypeMap.Add(ERROR_TYPE_FAULT, fault);
            errorTypeMap.Add(ERROR_TYPE_ERROR, error);
        }

        /// <summary>
        /// 取得告警类型列表
        /// </summary>
        /// <returns></returns>
        public static ICollection<ErrorType> getErrorList()
        {
            return errorTypeMap.Values;
        }

        /// <summary>
        /// 根据代码取得错误类型
        /// </summary>
        /// <returns></returns>
        public static ErrorType getErrortypeByCode(int code){
            return errorTypeMap[code];
        }

        public ErrorType()
        {
        }
        private IList<ErrorItem> _errorItemList;//协议
        public int code { get; set; }                 //类型代码
        public string errorItems { get; set; }        //包含的协议类型
        public string name                            //类型名称
        {
            get
            {
                string tmp = LanguageUtil.getDesc("ERRORTYPE_" + this.code);
                if (tmp == null) tmp = LanguageUtil.getDesc("UNKNOWN");
                return tmp;
            }
        }

        public IList<ErrorItem> errorItemList
        {
            get
            {
                if (_errorItemList == null)
                {
                    _errorItemList = new List<ErrorItem>();

                    string[] mcArr = this.errorItems.Split(',');
                    foreach (string mc in mcArr)
                    {
                        _errorItemList.Add(ErrorItem.getErrotItemByCode(int.Parse(mc)));
                    }
                }
                return _errorItemList;
            }
        }
    }
}
