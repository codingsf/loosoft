using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IBatisNet.DataAccess;
using Cn.Loosoft.Zhisou.SunPower.Persistence.Interfaces;
using Cn.Loosoft.Zhisou.SunPower.Common;
using Cn.Loosoft.Zhisou.SunPower.Domain;
namespace Cn.Loosoft.Zhisou.SunPower.Service
{
    /// <summary>
    /// 功能：宣传图片服务
    /// 作者：张月
    /// 时间：2011年4月22日 
    /// </summary>
    public class AdpicService
    {
        AdpicService adpicService = AdpicService.GetInstance();  //电站单元服务 
        private static AdpicService _instance = new AdpicService();
        private IDaoManager _daoManager = null;
        private IAdpic _adpic = null;

        private AdpicService()
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _adpic = _daoManager.GetDao(typeof(IAdpic)) as IAdpic;
        }

        public static AdpicService GetInstance()
        {
            return _instance;
        }
        /// <summary>
        /// 根据id获取宣传图片
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Adpic GetAdpic(int id)
        {
            return _adpic.Get(new Adpic { id = id });
        }
        /// <summary>
        /// 获取所有的宣传图片
        /// </summary>
        /// <returns></returns>
        public IList<Adpic> GetAdpicPage(Pager page)
        {
            return _adpic.GetAdpicPage(page);
        }
        /// <summary>
        /// 修改宣传图片信息
        /// </summary>
        /// <param name="productPicture">宣传图片实体</param>
        /// <returns></returns>
        public int ModifyAdpic(Adpic adpic)
        {
            return _adpic.Update(adpic);
        }
        /// <summary>
        /// 添加宣传图片信息
        /// </summary>
        /// <param name="productPicture">宣传图片实体</param>
        /// <returns></returns>
        public int AddAdpic(Adpic adpic)
        {
            return _adpic.Insert(adpic);
        }
        /// <summary>
        /// 删除宣传图片
        /// </summary>
        /// <param name="productPicture">宣传图片实体</param>
        /// <returns></returns>
        public int DelAdpic(int id)
        {
            return _adpic.Remove(new Adpic { id = id });
        }
        /// <summary>
        /// 根据语言获取所有图片
        /// </summary>
        /// <param name="adpic"></param>
        /// <returns></returns>
        public IList<Adpic> GetAdpicByLanguage(string language)
        {
            return _adpic.GetAdpicByLanguage(new Adpic { language = language }); 
        }
    }
}
