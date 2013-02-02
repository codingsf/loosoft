using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.Tenghu.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.Tenghu.Domain;

namespace Cn.Loosoft.Zhisou.Tenghu.Service
{
  public  class OrderService
    {
      private static OrderService _instance;
        private IDaoManager _daoManager = null;
        private IOrder _orderDao = null;

        private OrderService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _orderDao = _daoManager.GetDao(typeof(IOrder)) as IOrder;
        }

        public static OrderService GetInstance()
        {
            if (_instance == null)
            {
                _instance = new OrderService();
            }
            return _instance;
        }

        public int Save(OrderInfo order)
        {
            if (order.id > 0)
              return  _orderDao.Update(order);
            else
                return _orderDao.Insert(order);
        }
        public IList<OrderInfo> GetList()
        {
            return _orderDao.Getlist(new OrderInfo());
        }

        public int Remove(int id)
        {
            return _orderDao.Remove(new OrderInfo() {  id= id});
        }

        public OrderInfo Get(int id)
        {
            return _orderDao.Get(new OrderInfo() { id= id });
        }
    }
}
