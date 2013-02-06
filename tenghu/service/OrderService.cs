using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;

using DataLinq;
using LinqDAO;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
    public class OrderService
    {
        private static OrderService _instance;
        //private IDaoManager _daoManager = null;
        private OrderInfoDAO _orderDao = null;

        private OrderService()
        {
            // _daoManager = ServiceConfig.GetInstance().DaoManager;
            //_orderDao = _daoManager.GetDao(typeof(IOrder)) as IOrder;
            _orderDao = new OrderInfoDAO();
        }

        public static OrderService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new OrderService();
            }
            return _instance;
        }

        public void Save(OrderInfo order)
        {
            if (order.id > 0)
                _orderDao.Update(order);
            else
                _orderDao.Insert(order);
        }
        public IList<OrderInfo> GetList()
        {
            return _orderDao.GetList();
        }

        public void Remove(int id)
        {
            _orderDao.Remove(id);
        }

        public OrderInfo Get(int id)
        {
            return _orderDao.Get(id);
        }
    }
}
