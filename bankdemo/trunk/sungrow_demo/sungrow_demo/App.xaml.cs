using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Windows;

namespace sungrow_multitouch
{
    /// <summary>
    /// App.xaml 的交互逻辑
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {

            base.OnStartup(e);
            string langPath = "/lang/zh.xaml";
            App.Current.Resources.MergedDictionaries.Clear();
            App.Current.Resources.MergedDictionaries.Add(new ResourceDictionary() { Source = new Uri(langPath, UriKind.RelativeOrAbsolute) });

        }
    }
}
