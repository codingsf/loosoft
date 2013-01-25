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
using System.Windows.Threading;
using System.Windows.Forms.Integration;
using sungrow_touch;
using sungrow_demo.Service.vo;
using System.IO;

namespace sungrow_demo
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public static bool isAuto = false;
        private Dictionary<string, Image> initImages = new Dictionary<string, Image>();
        private const int datatype_count = 0;//电站总数数据
        private const int datatype_dayp = 1;//日发电量
        private const int datatype_totalp = 2;//总发电量
        private const int datatype_co2 = 3;//co2减排
        private const int datatype_income = 4;//收益
        const int MAX_COLUMN = 6;
        ConfigPara config = ConfigManagerService.GetInstance().LoadConfig();
        public MainWindow()
        {
            try
            {
                //this.Topmost = true;
                InitializeComponent();
                this.WindowState = WindowState.Maximized;
                initDataImageHash();
                dynamicIcoUri();
                fixData();
                initLogo();
            }
            catch (Exception ee)
            {
                LogUtil.error("MainWindow error:" + ee.StackTrace);
            }
        }

        private void initLogo()
        {
            string path = string.Format("{0}/images/logo.jpg", System.Environment.CurrentDirectory);
            if (File.Exists(path) == false)
                return;
            Uri uri = new Uri(path, UriKind.Absolute);
            BitmapImage logoImage = new BitmapImage(uri);
            imglogo.Source = logoImage;

        }


        /// <summary>
        /// 根据语言动态设置ico图片路径
        /// </summary>
        public void dynamicIcoUri()
        {
            string path = string.Format(System.Environment.CurrentDirectory + "/Resources/{0}/{1}.png", config.langInfo, "{0}");
            ico01.Source = new BitmapImage(new Uri(string.Format(path, ico01.Name), UriKind.RelativeOrAbsolute));
            ico02.Source = new BitmapImage(new Uri(string.Format(path, ico02.Name), UriKind.RelativeOrAbsolute));
            ico03.Source = new BitmapImage(new Uri(string.Format(path, ico03.Name), UriKind.RelativeOrAbsolute));
            ico04.Source = new BitmapImage(new Uri(string.Format(path, ico04.Name), UriKind.RelativeOrAbsolute));
            ico05.Source = new BitmapImage(new Uri(string.Format(path, ico05.Name), UriKind.RelativeOrAbsolute));
            ico06.Source = new BitmapImage(new Uri(string.Format(path, ico06.Name), UriKind.RelativeOrAbsolute));
            ico07.Source = new BitmapImage(new Uri(string.Format(path, ico07.Name), UriKind.RelativeOrAbsolute));
            ico08.Source = new BitmapImage(new Uri(string.Format(path, ico08.Name), UriKind.RelativeOrAbsolute));
        }
        /// <summary>
        /// 初始化数字对应图片
        /// </summary>
        private void initDataImageHash()
        {
            initImages.Add("1", dataImage1);
            initImages.Add("2", dataImage2);
            initImages.Add("3", dataImage3);
            initImages.Add("4", dataImage4);
            initImages.Add("5", dataImage5);
            initImages.Add("6", dataImage6);
            initImages.Add("7", dataImage7);
            initImages.Add("8", dataImage8);
            initImages.Add("9", dataImage9);
            initImages.Add("0", dataImage0);
            initImages.Add("kg", dataImagekg);
            initImages.Add("kt", dataImagekt);
            initImages.Add("kWh", dataImagekwh);
            initImages.Add("MWh", dataImagemwh);
            initImages.Add("GWh", dataImagegwh);
            initImages.Add("W", dataImagew);
            initImages.Add("Ke", dataImageke);
            initImages.Add("kW", dataImagekw);
            initImages.Add("MW", dataImagemw);
            initImages.Add("GW", dataImagegw);
            initImages.Add("kWp", dataImagekwp);
            initImages.Add("t", dataImaget);
            initImages.Add(".", dataImagedot);
            initImages.Add("ico01", ico01);
            initImages.Add("ico02", ico02);
            initImages.Add("ico03", ico03);
            initImages.Add("ico04", ico04);
            initImages.Add("ico05", ico05);
            initImages.Add("ico06", ico06);
            initImages.Add("ico07", ico07);
            initImages.Add("ico08", ico08);
            initImages.Add("rmb", rmb);//人民币
            initImages.Add("my", my);//美元
            initImages.Add("lubu", lubu);//卢布
            initImages.Add("hany", hany);//韩元
            initImages.Add("ouyuan", ouyuan);//欧元
            initImages.Add("ybang", ybang);//英镑
            initImages.Add("line", line);//分割线
        }

        private void showEarth()
        {
            ControlCenter.googleEarth.Show();
            this.Hide();
        }

        private void WindowLoaded(object sender, RoutedEventArgs e)
        {
            loadFlash();
        }

        private void axShockwaveFlash1_FSCommand(object sender, AxShockwaveFlashObjects._IShockwaveFlashEvents_FSCommandEvent e)
        {
            switch (e.command)
            {
                case "click":
                    {
                        showEarth();
                    }
                    break;
                case "close":
                    //Application.Exit();
                    break;
                default:
                    break;
            }
        }

        private void loadFlash()
        {
            // 创建 host 对象
            System.Windows.Forms.Integration.WindowsFormsHost host = new System.Windows.Forms.Integration.WindowsFormsHost();

            // 实例化 axShockwaveFlash1
            AxShockwaveFlashObjects.AxShockwaveFlash axShockwaveFlash1 = new AxShockwaveFlashObjects.AxShockwaveFlash();

            // 装载.axShockwaveFlash1
            host.Child = axShockwaveFlash1;
            axShockwaveFlash1.Width = 1366;
            axShockwaveFlash1.Height = 599;

            //将 host 对象嵌入FlashGrid
            this.touchPad.Children.Add(host);
            Canvas.SetTop(host, 91);
            // 设置 .swf 文件相对路径
            string swfPath = System.Environment.CurrentDirectory;
            swfPath += @"\demo.swf";
            axShockwaveFlash1.Movie = swfPath;
            axShockwaveFlash1.FSCommand += new AxShockwaveFlashObjects._IShockwaveFlashEvents_FSCommandEventHandler(this.axShockwaveFlash1_FSCommand);
        }

        private void lblNext_MouseDown(object sender, MouseButtonEventArgs e)
        {
            this.WelcomeWindow.Hide();
            GoogleEarth ge = new GoogleEarth();
            ge.Show();
        }

        private void WelcomeWindow_Initialized(object sender, EventArgs e)
        {
            //SysConfig config = new SysConfig();
            //config.Show();
            //this.Hide();
        }

        /// <summary>
        /// 填充首页数据
        /// </summary>
        private void fixData()
        {
            TotalInfo total = new TotalInfo();
            try
            {
                ConfigPara cp = ConfigManagerService.GetInstance().LoadConfig();
                lblSysName.Content = cp.sysname;
                string root_url = cp.domain;
                string username = "";
                if (cp.CounterType == ConfigPara.currentUser)
                {
                    username = cp.CounterUser;
                }
                string json = JsonUtil.loadJsonStr(root_url + "/openapi/totalinfo?username=" + username, "en-us");
                total = JsonUtil.Deserialize<TotalInfo>(json);
                if (total == null) return;
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
                return;
            }

            string[] items = config.displayItems.Split('|');
            int index = 0;

            foreach (var item in items)
            {
                string data = string.Empty;
                string unit = string.Empty;
                if (string.IsNullOrEmpty(item))
                    continue;
                switch (item)//item 对应 configpara.displayItemsName 索引
                {
                    case "0":
                        data = total.plantsCount.ToString();
                        unit = "";
                        break;
                    case "1":
                        data = total.totalDayEnergy.ToString("0.00");
                        unit = total.totalDayEnergyUnit;
                        break;
                    case "2":
                        data = total.totalEnergy.ToString("0.00");
                        unit = total.totalEnergyUnit;
                        break;
                    case "3":
                        data = total.totalCO2Reduce.ToString("0.00");
                        unit = total.totalCO2ReduceUnit;
                        break;
                    case "4":
                        unit = "rmb";
                        switch (config.currencyType)
                        {
                            case ConfigPara.MY:
                                unit = "my";
                                break;
                            case ConfigPara.LUBU:
                                unit = "lubu";
                                break;
                            case ConfigPara.HANYUAN:
                                unit = "hany";
                                break;
                            case ConfigPara.OUYUAN:
                                unit = "ouyuan";
                                break;
                            case ConfigPara.YBANG:
                                unit = "ybang";
                                break;
                            default:
                                break;

                        }
                        data = (total.totalEnergy * (double)config.incomeRate).ToString("0.00");
                        break;
                    case "5"://今日功率
                        data = total.totalTodayPower.ToString("0.00");
                        unit = total.totalTodayPowerUnit;
                        break;
                    case "6"://总装机容量
                        data = total.totalPower.ToString("0.00");
                        unit = total.totalPowerUnit;
                        break;
                    case "7":
                        data = total.treeNum;
                        unit = "Ke";
                        break;
                }
                addDataImage(data, unit, index++, int.Parse(item), touchPad);

            }
            ////添置电站数量数据
            //addDataImage(total.plantsCount.ToString(), "", datatype_count, touchPad);
            ////添加电站日发电量
            //addDataImage(total.totalDayEnergy.ToString("0.00"), total.totalDayEnergyUnit, datatype_dayp, touchPad);
            ////添加电站总发电量
            //addDataImage(total.totalEnergy.ToString("0.00"), total.totalEnergyUnit, datatype_totalp, touchPad);
            ////添加电站co2减排
            //addDataImage(total.totalCO2Reduce.ToString("0.00"), total.totalCO2ReduceUnit, datatype_co2, touchPad);
            ////收益
            //string key = "rmb";
            //switch (config.currencyType)
            //{
            //    case ConfigPara.MY:
            //        key = "my";
            //        break;
            //    case ConfigPara.LUBU:
            //        key = "lubu";
            //        break;
            //    case ConfigPara.HANYUAN:
            //        key = "hany";
            //        break;
            //    case ConfigPara.OUYUAN:
            //        key = "ouyuan";
            //        break;
            //    case ConfigPara.YBANG:
            //        key = "ybang";
            //        break;
            //    default:
            //        break;

            //}
            //addDataImage((total.totalEnergy * (double)config.incomeRate).ToString("0.00"), key, datatype_income, touchPad);
        }
        /// <summary>
        /// 追加数据图片到容器画布
        /// </summary>
        /// <param name="data"></param>
        /// <param name="unit"></param>
        /// <param name="data_type"></param>
        /// <param name="container"></param>
        private void addDataImage(string data, string unit, int index, int data_type, Canvas container)
        {
            //某类类似数据在画布中开始位置
            int top = 725;//画布中的高度，所有数据固定的，都一样
            int startLeft = 0;
            int icostartLeft = 0;
            int lineStartLeft = 0;
            switch (index)
            {
                case (0)://第一个位置
                    startLeft = 110;
                    icostartLeft = 61;
                    lineStartLeft = 261;
                    break;
                case (1)://第二个位置
                    startLeft = 365;
                    icostartLeft = 322;
                    lineStartLeft = 540;
                    break;
                case (2)://第三个位置
                    startLeft = 633;
                    icostartLeft = 583;
                    lineStartLeft = 810;
                    break;
                case (3)://第四个位置
                    startLeft = 885;
                    icostartLeft = 842;
                    lineStartLeft = 1070;
                    break;
                case (4)://第五个位置
                    startLeft = 1152;
                    icostartLeft = 1102;
                    break;
                default:
                    startLeft = 130;
                    break;
            }
            //icostartLeft += 15;
            //startLeft += 15;
            //lineStartLeft += 15;
            int width = 0;
            int showItems = config.displayItems.Split('|').Length;
            width = (MAX_COLUMN - showItems) * 135;
            icostartLeft += width;
            startLeft += width;
            lineStartLeft += width;
            Image icoimage = new Image();
            icoimage.Width = 200;
            icoimage.Height = 60;
            icoimage.Source = initImages[string.Format("ico0{0}", data_type + 1)].Source;

            Canvas.SetLeft(icoimage, icostartLeft);
            Canvas.SetTop(icoimage, 5);
            bgtouchPad.Children.Add(icoimage);


            if (data_type < 4)
            {
                icoimage = new Image();
                icoimage.Width = 5;
                icoimage.Height = 78;
                icoimage.Source = initImages["line"].Source;
                Canvas.SetLeft(icoimage, lineStartLeft);
                Canvas.SetTop(icoimage, 0);
                bgtouchPad.Children.Add(icoimage);
            }




            string tmpdata;
            bool isdot = false;
            for (int i = 0; i < data.Length; i++)
            {
                Image image = new Image();
                tmpdata = data.Substring(i, 1);
                //取出对应的图片
                image.Source = initImages[tmpdata].Source;
                if (!tmpdata.Equals("."))
                {
                    if (isdot)
                    {
                        startLeft += 6;
                        image.Width = 16;
                        image.Height = 21;
                        isdot = false;
                    }
                    else
                    {
                        startLeft += 16;
                        image.Width = 16;
                        image.Height = 21;
                    }
                }
                else if (tmpdata.Equals("."))
                {
                    startLeft += 16;
                    image.Width = 6;
                    image.Height = 21;
                    isdot = true;
                }
                Canvas.SetLeft(image, startLeft);
                Canvas.SetTop(image, top);
                container.Children.Add(image);
            }
            //追加单位数据图片
            //取出对应的图片
            if (unit != null && !unit.Equals(""))
            {
                Image unitImage = new Image();
                unitImage.Source = initImages[unit].Source;
                startLeft += 14;
                unitImage.Height = 21;
                Canvas.SetLeft(unitImage, startLeft);
                Canvas.SetTop(unitImage, top);
                container.Children.Add(unitImage);
            }

        }

        private void WelcomeWindow_KeyDown(object sender, KeyEventArgs e)
        {
            //ctrl+S   保存 
            if (e.Key == Key.F4)//ctrl+s   
            {
                //先kill
                SystemUtil.KillProcess("sungrow_touch");

                //先清理资源再退出程序
                if (Main.cc != null) Main.cc.clear();
                //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
                //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
                //geProcess.Kill();
                this.Close();

                Environment.Exit(0);
            }
        }

    }
}
