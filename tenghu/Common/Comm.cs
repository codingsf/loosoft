using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;

namespace Cn.Loosoft.Zhisou.Tenghu.Common
{
   public class Comm
    {
       private static IList<SelectListItem> jyan;
       private static IList<SelectListItem> area;
       private static IList<SelectListItem> networkType;
       private static IList<SelectListItem> xueli;
       private static IList<SelectListItem> buyTime;
       private static IList<SelectListItem> payMent;

       public static IList<SelectListItem> Jyan
       {
           get
           {
               jyan=new List<SelectListItem>();
               jyan.Add(new SelectListItem() { Text = "一年以上", Value = "一年以上" });
               jyan.Add(new SelectListItem() { Text = "二年以上", Value = "二年以上" });
               jyan.Add(new SelectListItem() { Text = "三年以上", Value = "三年以上" });
               jyan.Add(new SelectListItem() { Text = "五年以上", Value = "五年以上" });
               jyan.Add(new SelectListItem() { Text = "不限", Value = "不限", Selected = true });
               return jyan;
           }
       }

       public static IList<SelectListItem> Xueli
       {
           get
           {
               xueli = new List<SelectListItem>();
               xueli.Add(new SelectListItem() { Text = "中专", Value = "中专" });
               xueli.Add(new SelectListItem() { Text = "大专", Value = "大专" });
               xueli.Add(new SelectListItem() { Text = "本科", Value = "本科" });
               xueli.Add(new SelectListItem() { Text = "研究生", Value = "研究生" });
               xueli.Add(new SelectListItem() { Text = "不限", Value = "不限", Selected = true });
               return xueli;
           }
       }

       public static IList<SelectListItem> Area
       {
           get
           {
               area = new List<SelectListItem>();
               area.Add(new SelectListItem() { Value = "-1", Text = "--请选择所在地--" });
               area.Add(new SelectListItem() { Value = "1", Text = "北京市" });
               area.Add(new SelectListItem() { Value = "2", Text = "天津市" });
               area.Add(new SelectListItem() { Value = "3", Text = "河北省" });
               area.Add(new SelectListItem() { Value = "4", Text = "山西省" });
               area.Add(new SelectListItem() { Value = "5", Text = "内蒙古自治区" });
               area.Add(new SelectListItem() { Value = "6", Text = "辽宁省" });
               area.Add(new SelectListItem() { Value = "7", Text = "吉林省" });
               area.Add(new SelectListItem() { Value = "8", Text = "黑龙江省" });
               area.Add(new SelectListItem() { Value = "9", Text = "上海市" });
               area.Add(new SelectListItem() { Value = "10", Text = "江苏省" });
               area.Add(new SelectListItem() { Value = "11", Text = "浙江省" });
               area.Add(new SelectListItem() { Value = "12", Text = "安徽省" });
               area.Add(new SelectListItem() { Value = "13", Text = "福建省" });
               area.Add(new SelectListItem() { Value = "14", Text = "江西省" });
               area.Add(new SelectListItem() { Value = "15", Text = "山东省" });
               area.Add(new SelectListItem() { Value = "16", Text = "河南省" });
               area.Add(new SelectListItem() { Value = "17", Text = "湖北省" });
               area.Add(new SelectListItem() { Value = "18", Text = "湖南省" });
               area.Add(new SelectListItem() { Value = "19", Text = "广东省" });
               area.Add(new SelectListItem() { Value = "20", Text = "广西壮族自治区" });
               area.Add(new SelectListItem() { Value = "21", Text = "海南省" });
               area.Add(new SelectListItem() { Value = "22", Text = "重庆市" });
               area.Add(new SelectListItem() { Value = "23", Text = "贵州省" });
               area.Add(new SelectListItem() { Value = "24", Text = "四川省" });
               area.Add(new SelectListItem() { Value = "25", Text = "西藏自治区" });
               area.Add(new SelectListItem() { Value = "26", Text = "云南省" });
               area.Add(new SelectListItem() { Value = "27", Text = "陕西省" });
               area.Add(new SelectListItem() { Value = "28", Text = "甘肃省" });
               area.Add(new SelectListItem() { Value = "29", Text = "青海省" });
               area.Add(new SelectListItem() { Value = "30", Text = "宁夏回族自治区" });
               area.Add(new SelectListItem() { Value = "31", Text = "新疆维吾尔自治区" });
               return area;
           }
       }

       public static IList<SelectListItem> NetworkType
       {
           get
           {
               networkType = new List<SelectListItem>();
               networkType.Add(new SelectListItem() { Value = "-1", Text = "--请选择网店类型--", Selected = true });
               networkType.Add(new SelectListItem() { Value = "100", Text = "产业园" });
               networkType.Add(new SelectListItem() { Value = "200", Text = "销售|代理商网点" });
               networkType.Add(new SelectListItem() { Value = "300", Text = "服务网点" });
               networkType.Add(new SelectListItem() { Value = "400", Text = "配件仓库" });
               networkType.Add(new SelectListItem() { Value = "500", Text = "6S店" });
               return networkType;
           }
       }

       public static IList<SelectListItem> BuyTime
       {
           get
           {
               buyTime = new List<SelectListItem>();
               buyTime.Add(new SelectListItem() { Text = "--请选择采购时间--", Value = "0" });
               buyTime.Add(new SelectListItem() { Text = "一周内", Value = "一周内" });
               buyTime.Add(new SelectListItem() { Text = "一月内", Value = "一月内" });
               buyTime.Add(new SelectListItem() { Text = "三月内", Value = "三月内" });
               buyTime.Add(new SelectListItem() { Text = "半年内", Value = "半年内" });
               buyTime.Add(new SelectListItem() { Text = "一年内", Value = "一年内" });
               return buyTime;
           }
       }

       public static IList<SelectListItem> PayMent
       {
           get
           {
               payMent = new List<SelectListItem>();
               payMent.Add(new SelectListItem() { Text = "--请选择付款方式--", Value = "0" });
               payMent.Add(new SelectListItem() { Text = "全款", Value = "全款" });
               payMent.Add(new SelectListItem() { Text = "按揭分期", Value = "按揭分期" });
               payMent.Add(new SelectListItem() { Text = "融资租赁", Value = "融资租赁" });
               payMent.Add(new SelectListItem() { Text = "其他", Value = "其他" });
               return payMent;
           }
       }



    }
}
