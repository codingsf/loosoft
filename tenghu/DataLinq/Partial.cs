using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cn.Loosoft.Zhisou.Tenghu.Common;
using System.Web.Mvc;

namespace DataLinq
{
    public partial class News
    {
        public Category category
        {
            get
            {
                return this.Category;
            }
        }

        

        public News nextnews { get; set; }

        public News prenews { get; set; }
        public string imgUrl
        {
            get
            {
                string src = Util.GetImage(descr);
                if (string.IsNullOrEmpty(src))
                {
                    src = string.Format("/img/default/default_{0}.jpg", this.Category != null ? Category.id : 0);
                }
                return src;
            }

        }

        public string text
        {
            get
            {
                return Util.FilterHtml(descr);
            }

        }
    }



    public partial class Category
    {
        public int? sortOrder
        {
            get
            {
                return this.sortorder;
            }
        }

        public List<Category> ChildCategory
        {
            get
            {
                return this.Category2.ToList<Category>();
            }
        }

        public string img
        {
            get
            {
                string src = Util.GetImage(descr);
                if (string.IsNullOrEmpty(src))
                    src = string.Format("/img/default/default_{0}.jpg", id);
                return src;

            }
        }
        public string text
        {
            get
            {
                return Util.FilterHtml(descr);
            }
        }

    }


    public partial class Video
    {
        public string pic
        {
            get
            {
                if (string.IsNullOrEmpty(img))
                    return string.Format("default/default_video.jpg");
                return img;
            }
        }
    }

    public partial class Zhuanli
    {
        public Category category
        {
            get
            {
                return this.Category;
            }
        }
    }


    public partial class ServiceInfo
    {

        public string area
        {
            get
            {
                foreach (SelectListItem item in Comm.Area)
                {
                    if (item.Value.Equals(areaid.ToString()) && areaid > 0)
                        return item.Text;
                }
                return string.Empty;
            }
        }

        public string nettype
        {
            get
            {
                foreach (var item in Comm.NetworkType)
                {
                    if (item.Value.Equals(nettypeid.ToString()) && nettypeid > 0)
                        return item.Text;
                }
                return string.Empty;
            }
        }

    }


    public partial class Video
    {
        public Category category
        {
            get
            {
                return this.Category;
            }
        }
    }

    public partial class OrderInfo
    {


        public Product product
        {
            get
            {
                return this.Product;
            }
        }

        public string areaname
        {
            get
            {
                foreach (SelectListItem item in Comm.Area)
                {
                    if (item.Value.Equals(area))
                        return item.Text;
                }
                return string.Empty;
            }
        }


        public Category category
        {
            get
            {
                return this.Category;
            }
        }
    }
}
