using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.SunPower.Common;

namespace Cn.Loosoft.Zhisou.SunPower.Domain
{ 
    /// <summary>
    /// 报表数据项业务类，供后台维护，但是不能新增和删除
    /// </summary>
    [Serializable]
    public class ReportDataItem
    {
        public ReportDataItem() { }
        public ReportDataItem(int code,string name,bool enabled) {
            this.id = code;
            this.name = name;
            this.Enabled = enabled;
        }
        public ReportDataItem(int code)
        {
            this.id = code;
            
        }
        private string _name;
        private bool _enabled;

        public int id { get; set; }                 //数据项代码，只能是DataItem类中定义的

        public bool Enabled
        {
            get { return _enabled; }
            set { _enabled = value; }
        }
        public string name                            //测点名称
        {
            set
            {
                this._name = value;
            }
            get
            {
                return _name;
            }
        }
    }
}
