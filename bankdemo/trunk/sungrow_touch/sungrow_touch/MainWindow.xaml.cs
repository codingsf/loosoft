using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using sungrow_demo.model;
using sungrow_demo.Service;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using SharpPlatform.GeDemo;
using System.Windows.Threading;
using sungrow_demo.Service.vo;

namespace sungrow_touch
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            this.Hide();
            MainForm mf = new MainForm();
            mf.Hide();
        }
    }
}
