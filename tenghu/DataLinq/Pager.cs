using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.Tenghu.Common
{
    /// <summary>
    /// 排序方式
    /// </summary>
    public enum OrderType
    {
        /// <summary>
        /// 升序
        /// </summary>
        ASC = 0,
        /// <summary>
        /// 降序
        /// </summary>
        DESC = 1
    }

    public class Pager
    {
        private int _pageSize;

        public int PageSize
        {
            get
            {
                return _pageSize > 0 ? _pageSize : 1;
            }
            set
            {
                _pageSize = value;
            }
        }

        private int _pageIndex;

        public int PageIndex
        {
            get
            {
                return _pageIndex > 0 ? _pageIndex : 1;

            }
            set
            {
                _pageIndex = value;
            }
        }

        public int Start
        {
            get
            {
                return (PageIndex - 1) * PageSize;
            }
        }

        public int End
        {
            get
            {
                return PageSize;
            }
        }

        public int RecordCount { get; set; }

        public bool IsNext
        {
            get
            {
                return PageCount > PageIndex;
            }
        }

        public bool IsPre
        {
            get
            {
                return PageIndex > 1;
            }
        }

        public int PreNo
        {
            get
            {
                return PageIndex-1;
            }
        }

        public int NextNo
        {
            get
            {
                return PageIndex + 1;
            }
        }

        public bool IsFirst
        {
            get
            {
                return PageIndex == 1;
            }
        }

        public bool IsLast
        {
            get
            {
                return PageIndex == PageCount;
            }
        }

        public int PageCount
        {
            get
            {
                int count = RecordCount % PageSize > 0 ? RecordCount / PageSize + 1 : RecordCount / PageSize;
                return count > 0 ? count : 1;

            }
        }

    }
}