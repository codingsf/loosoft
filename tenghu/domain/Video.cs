using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cn.Loosoft.Zhisou.Tenghu.Domain
{
  public  class Video
    {
      public int id { get; set; }
      public Category category { get; set; }
      public string name { get; set; }
      public string descr { get; set; }
      public string path { get; set; }
      public string img { get; set; }
      public bool isdisplay { get; set; }
      public int sortorder { get; set; }
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
}
