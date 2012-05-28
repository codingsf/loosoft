using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Domain;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using System.Collections;
using IBatisNet.DataAccess;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
  public  class ReportDataItemService
    {
       private static ReportDataItemService _instance = new ReportDataItemService();
        private IDaoManager _daoManager = null;
        private IReportDataItemDao _dataItemDao = null;

        //保存用户名和id键值对 以便用key查询提供查询速度
        private static Hashtable usernameIdMap = new Hashtable();

        private ReportDataItemService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _dataItemDao = _daoManager.GetDao(typeof(IReportDataItemDao)) as IReportDataItemDao;
        }

        public static ReportDataItemService GetInstance()
        {
            return _instance;
        }

        public IList<ReportDataItem> GetDataItemsByPage(Pager page)
      {
          return _dataItemDao.GetDataItemList(page);
      }
        public int UpdateItemEnabled(string id, int enabled)
        {
            return _dataItemDao.UpdateItemEnabled(id,enabled);
        }
        public IList<ReportDataItem> GetEnabledDataItemList()
        {
            return _dataItemDao.GetEnabledDataItemList();
        }
        public IList<ReportDataItem> GetUnEnabledDataItemList()
        {
            return _dataItemDao.GetUnEnabledDataItemList();
        }
        public IList<DataItem> GetDataItemListByCode(int code)
        {
            return DataItem.dataItemMap[code];
        }
        public IList<DataItem> GetFilterDataItemListByCode(int code)
        {
            string filterStr = string.Empty;
            string[] filterArray = null;
            ReportDataItem item = ReportDataItemService.GetInstance().Get(new ReportDataItem() { id = code });
            filterStr = item == null ? "," : (item.name == null ? "," : item.name);
            filterArray = filterStr.Split(',');
            IList<DataItem> dataItems = DataItem.dataItemMap[code];
            IList<DataItem> newItems = new List<DataItem>();
            bool isHave = false;
            foreach (var titem in dataItems)
            {
                isHave = false;
                foreach (string filter in filterArray)
                {
                    if (titem.code.ToString().Equals(filter))
                    {
                        isHave = true;
                        break;
                    }
                  
                }
                if (isHave)
                    newItems.Add(titem);

            }

            return newItems;
        }


        public int Insert(ReportDataItem item)
        {
            return _dataItemDao.Insert(item);
        }

        public int Remove(ReportDataItem item)
        {
            return _dataItemDao.Remove(item);
        }
        public ReportDataItem Get(ReportDataItem item)
        {
            return _dataItemDao.Get(item);
        }

    }
}
