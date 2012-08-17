using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 错误码service
    /// </summary>
    public class ErrorcodeService
    {
        private static ErrorcodeService _instance = new ErrorcodeService();
        private IDaoManager _daoManager = null;
        private IErrorcodeDao _errorcodeDao = null;

        private ErrorcodeService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _errorcodeDao = _daoManager.GetDao(typeof(IErrorcodeDao)) as IErrorcodeDao;
        }

        public static ErrorcodeService GetInstance()
        {
            return _instance;
        }

        public IList<Errorcode> GetList()
        {
            return _errorcodeDao.Getlist(new Errorcode());
        }

        public int Remove(int id)
        {
            int res = _errorcodeDao.Remove(new Errorcode { id = id });
            if (res > 0) {
                //设置静态数据
                setErrorStaticData();
            }
            return res;
        }

        public Errorcode Get(int id)
        {
            return _errorcodeDao.Get(new Errorcode { id = id });
        }

        public int Save(Errorcode errorCode)
        {
            int res = 0;
            if (errorCode.id > 0)
                res = _errorcodeDao.Update(errorCode);
            else
            {
                res = _errorcodeDao.Insert(errorCode);
            }
            //设置静态数据
            setErrorStaticData();
            return res;
        }

        /// <summary>
        /// 此方法用于兼容旧预定义错误码的方式，和新的后台维护的方式
        /// 思路是：在增删改错误码是调用此方法同步修改错误码和错误类型静态数据，同时同步到缓存，这样数据解析器调用通过错误码取得错误类型的方法哪里增加
        /// 从memcached缓存获取的方式，保证和错误码的数据保持一致。这样就不同动原来结构了
        /// </summary>
        public void setErrorStaticData() {
            IList<Errorcode> errorcodes = this.GetList();
            if (errorcodes.Count == 0) return;
            //更新错误码静态数据
            ErrorItem.errorItemMap.Clear();
            //更新错误类型静态数据
            foreach (ErrorType et in ErrorType.errorTypeMap.Values)
            {
                et.errorItems = "";
            }

            foreach(Errorcode errorcode in errorcodes){
                if(ErrorItem.errorItemMap.ContainsKey(int.Parse(errorcode.code))){
                    ErrorItem.errorItemMap[int.Parse(errorcode.code)] = new ErrorItem() { code = int.Parse(errorcode.code), errorType = errorcode.errorType,name=errorcode.name, defaultName=errorcode.defaultName };
                }else{
                    ErrorItem.errorItemMap.Add(int.Parse(errorcode.code), new ErrorItem() { code = int.Parse(errorcode.code), errorType = errorcode.errorType,name=errorcode.name, defaultName=errorcode.defaultName });
                }
                if (ErrorType.errorTypeMap.ContainsKey(errorcode.errorType))
                {
                    ErrorType.errorTypeMap[errorcode.errorType].errorItems += "," + errorcode.code;
                }
                else {
                    ErrorType.errorTypeMap[errorcode.errorType] = new ErrorType() { code = errorcode.errorType, errorItems =  errorcode.code };
                }

                //同步更新缓存
                MemcachedClientSatat.getInstance().Set(CacheKeyUtil.buildErrorCode(errorcode.code), "type_" + errorcode.errorType);
            }
        }
    }
}
