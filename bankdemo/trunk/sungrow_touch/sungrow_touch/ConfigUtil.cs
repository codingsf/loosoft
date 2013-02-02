using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.IO;

namespace sungrow_touch
{
    class ConfigUtil
    {
        static string temp_image_path = ConfigurationSettings.AppSettings["temp_image_path"];
        public static  string getImagePath() { 
            if(!Directory.Exists(temp_image_path)){
                Directory.CreateDirectory(temp_image_path);
            }
            return temp_image_path;
        }
    }
}
