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
using System.Windows.Shapes;
using Visifire.Charts;
using sungrow_demo.Service.vo;
using System.Windows.Threading;
using System.IO;
using System.Threading;
using SharpPlatform.GeDemo;
using sungrow_demo.Service;
using System.Configuration;
using sungrow_demo.model;
using sungrow_touch.Service;

namespace sungrow_touch
{
    /// <summary>
    /// Detail_1.xaml 的交互逻辑
    /// </summary>
    public partial class Detail_1 : Window
    {
        static int chart_week = 1;
        static int chart_month = 2;
        //近几日发电量天数
        static int monthDay = int.Parse(ConfigurationManager.AppSettings["monthDay"]);
        static int weekDay = int.Parse(ConfigurationManager.AppSettings["weekDay"]);
        //详细页面弹出变大速度
        static int speed = int.Parse(ConfigurationManager.AppSettings["speed"]);
        //电站vomap
        private static IDictionary<string, PlantInfoVo> plantmap = new Dictionary<string, PlantInfoVo>();
        private string langinfo = ConfigManagerService.GetInstance().LoadConfig().langInfo;
        private string masterlang = ConfigManagerService.GetInstance().LoadConfig().masterLang.ToUpper();
        private string childlang = ConfigManagerService.GetInstance().LoadConfig().childLang.ToUpper();
        private string isDebug = ConfigurationManager.AppSettings["isDebug"];
        string plantId = "194";
        int columnWidth = 5;
        bool isdebug = false;
        bool isAuto = true;
        public static int WINDOW_HANDLER = 0;
        static string[] displayPages = null;
        static int offsetPx = 683;//分页图片偏移像素
        static Detail_1()
        {
            
            try
            {
                List<PlantInfoVo> hotPlants = ConfigManagerService.GetInstance().LoadConfig().TipsPlantsInfo;
                string pages = ConfigManagerService.GetInstance().LoadConfig().displayPages;
                pages = "0|" + pages;
                if (pages.EndsWith("|")) pages = pages.Substring(0, pages.Length - 1);
                displayPages = pages.Split('|');
                offsetPx = 32 * (4 - displayPages.Count());
                foreach (PlantInfoVo plantInfoVo in hotPlants)
                {
                    plantmap.Add(plantInfoVo.plantId, plantInfoVo);
                }
            }
            catch (Exception ee) {
                LogUtil.error("Detail_1 error:" + ee.StackTrace);
            }

        }

        public Detail_1()
        {
            InitializeComponent();
            isdebug = true;
            isAuto = true;
            initLogo();
        }


        private void initLogo()
        { 
            string path=string.Format("{0}/images/insidelogo.jpg", System.Environment.CurrentDirectory);
            if (File.Exists(path) == false)
                return;
            Uri uri = new Uri(path,UriKind.Absolute);
            BitmapImage logoImage = new BitmapImage(uri);
            imginsideLogo.Source = logoImage;

        }
        public Detail_1(string plantId, bool isAuto)
        {
            if (isDebug.Equals("false"))
                this.Topmost = true;
            InitializeComponent();
            this.plantId = plantId;
            this.isAuto = isAuto;
        }

        /// <summary>
        /// 取得每个子页面的显示时间
        /// </summary>
        private int getOnePageTime()
        {
            try
            {
                return int.Parse(plantmap[this.plantId].detailInterval);
            }
            catch (Exception ee)
            {
                LogUtil.error("getOnePageTime error:" + ee.StackTrace);
                return 5;
            }
        }

        /// <summary>
        /// 改变整个页面背景
        /// </summary>
        /// <param name="bgName"></param>
        private void changeBg(string bgName)
        {
            try{
                string path = System.Environment.CurrentDirectory + "/Resources/Images/{0}";
                Uri url = new Uri(string.Format(path, bgName));
                BitmapImage bmp = new BitmapImage(url);
                ImageBrush imageBrush = new ImageBrush();
                imageBrush.ImageSource = bmp;
                LayoutRoot.Background = imageBrush;
            }catch(Exception ee){
                LogUtil.error("changeBg error:" + ee.StackTrace);
                sendCmdMessage("nextdetail");
                this.Close();
            }
        }

        /// <summary>
        /// 改变详情界面的大小，从无到有逐渐放大的效果。
        /// </summary>
        public void changesize()
        {
            LayoutRoot.Width = 0;
            LayoutRoot.Height = 0;
            try
            {
                this.Show();
            }
            catch (Exception ee) {
                LogUtil.error("changeBg error:" + ee.StackTrace);
            }


            //先隐藏
            lblPlantName.Visibility = Visibility.Hidden;
            gird1.Visibility = Visibility.Hidden;
            initPageTabImageLeft();
            changeCurDotbg(0);
            DispatcherTimer cdt = new DispatcherTimer();
            cdt.Interval = TimeSpan.FromMilliseconds(1);
            cdt.Tick += new EventHandler(delegate(object sender, EventArgs e)
            {
                if (LayoutRoot.Width < 1366)
                {
                    Matrix matrix = ((MatrixTransform)LayoutRoot.RenderTransform).Matrix;
                    Point center = new Point(LayoutRoot.Width / 2, LayoutRoot.Height / 2);
                    center = matrix.Transform(center);
                    LayoutRoot.Opacity = 1 * (LayoutRoot.Width / 1366.00);
                    LayoutRoot.Width = LayoutRoot.Width + (speed * 13.66);
                    LayoutRoot.Height = LayoutRoot.Height + (speed * 7.68);
                }
                else
                {
                    LayoutRoot.Width = 1366;
                    LayoutRoot.Height = 768;
                    gird1.Visibility = Visibility.Visible;
                    lblPlantName.Visibility = Visibility.Visible;
                    imgPlant.Visibility = Visibility.Visible;
                    cdt.Stop();
                    if (isAuto)
                        timerChange();
                }
            });//调用函数
            cdt.Start();
        }

        int pageIndex = 0;//页面下标
        int curPage = 0;//当前播放页面号码
        DispatcherTimer dtntimerChange = null;
        
        /// <summary>
        /// 关闭定时器
        /// </summary>
        private void stoptimer() {
            LogUtil.debug("开始停止详细页面轮播定时器");
            if (dtntimerChange != null) {
                dtntimerChange.Stop();
                LogUtil.debug("停止详细页面轮播定时器");
            }
        }

        /// <summary>
        /// 定时显示不同内容子页面，从第二个页面开始
        /// </summary>
        private void timerChange()
        {
            try
            {
                int onePageTime = this.getOnePageTime()+1;
                
                pageIndex = 0;
                //延迟后面动作
                dtntimerChange = new DispatcherTimer();
                dtntimerChange.Interval = TimeSpan.FromSeconds(onePageTime);
                dtntimerChange.Tick += new EventHandler(delegate(object sender1, EventArgs e1)
                {
                    pageIndex++;
                    LogUtil.debug("进入定时显示第"+pageIndex+"个子页面");
                    if (pageIndex >= displayPages.Count())
                    {
                        LogUtil.debug("结束显示所有子页面");
                        stoptimer();
                        sendCmdMessage("nextdetail");
                        return;
                    }
                    else
                    {
                        LogUtil.debug("定时显示第" + pageIndex + "个子页面");
                        displayPage(pageIndex);
                    }

                });//调用函数
                dtntimerChange.Start();
            }
            catch (Exception eee)
            {
                LogUtil.error("timerChange error:" + eee.StackTrace);
            }
        }

        /// <summary>
        /// 显示页面内容
        /// </summary>
        /// <param name="curPage"></param>
        private void displayPage(int pageIndex)
        {
            try
            {
                changeCurDotbg(pageIndex);
                if (pageIndex >= displayPages.Count()) return;

                curPage = int.Parse(displayPages[pageIndex]);
                string masterLangText = string.Empty;
                string childLangText = string.Empty;

                switch (curPage)
                {
                    case 0://详细信息
                        string langbg = string.Format("bgbg.{0}.jpg", langinfo);
                        this.changeBg(langbg);
                        gidEnergyGrid.Visibility = Visibility.Hidden;
                        gidPlantInfo.Visibility = Visibility.Visible;
                        gidPowerGrid.Visibility = Visibility.Hidden;
                        break;
                    case 1://两日功率
                        this.changeBg("bg.jpg");
                        gidPlantInfo.Visibility = Visibility.Hidden;
                        gidPowerGrid.Visibility = Visibility.Visible;
                        gidEnergyGrid.Visibility = Visibility.Hidden;
                        //设置功率图表的时间，并按此时间创建图表
                        DateTime endtime = DateTime.Now;
                        DateTime pstrartTime = endtime.AddDays(-1);
                        
                        tbxStartDate.Content = pstrartTime.ToString("MM/dd");
                        tbxStartDate.Tag = pstrartTime.ToString("yyyy/MM/dd");
                        
                        tbxEndDate.Content = endtime.ToString("MM/dd");
                        tbxEndDate.Tag = endtime.ToString("yyyy/MM/dd");
                        
                        lblPowerDate1.Content = this.formatDate(pstrartTime);//tbxStartDate.Content;
                        lblPowerDate2.Content = this.formatDate(endtime);//tbxEndDate.Content;
                        CreatePowerChart(pstrartTime.ToString("yyyyMMdd00"), DateTime.Now.ToString("yyyyMMdd23"));//功率图表
                        break;
                    case 2://七日发电量
                        masterLangText = App.Current.FindResource(string.Format("{0}_ChartWeekEnergy", masterlang)).ToString();
                        childLangText = App.Current.FindResource(string.Format("{0}_ChartWeekEnergy", childlang)).ToString();
                        this.changeBg("bg.jpg");
                        lblEnergyTitle.Content = string.Format("{0}({1})", masterLangText, childLangText);

                        gidPowerGrid.Visibility = Visibility.Hidden;
                        gidEnergyGrid.Visibility = Visibility.Visible;
                        gidPlantInfo.Visibility = Visibility.Hidden;
                        cal10Start.Visibility = System.Windows.Visibility.Hidden;
                        //设置发电量图表的时间，并按此时间创建图表
                        DateTime eStrartTime = DateTime.Now.AddDays(-1 * weekDay);
                        
                        
                        tbx10StartDate.Tag = eStrartTime.ToString("yyyy/MM/dd");
                        tbx10EndDate.Tag = DateTime.Now.ToString("yyyy/MM/dd");
                        tbx10StartDate.Content = eStrartTime.ToString("MM/dd");
                        tbx10EndDate.Content = DateTime.Now.ToString("MM/dd");


                        CreateEnergyChart(eStrartTime.ToString("yyyyMMdd"), DateTime.Now.ToString("yyyyMMdd"), chart_week);
                        break;
                    default://月发电量
                        masterLangText = App.Current.FindResource(string.Format("{0}_ChartMonthEnergy", masterlang)).ToString();
                        childLangText = App.Current.FindResource(string.Format("{0}_ChartMonthEnergy", childlang)).ToString();
                        this.changeBg("bg.jpg");

                        lblEnergyTitle.Content = string.Format("{0}({1})", masterLangText, childLangText);
                        gidPowerGrid.Visibility = Visibility.Hidden;
                        gidEnergyGrid.Visibility = Visibility.Visible;
                        gidPlantInfo.Visibility = Visibility.Hidden;
                        cal10Start.Visibility = System.Windows.Visibility.Hidden;
                        //设置发电量图表的时间，并按此时间创建图表
                        eStrartTime = DateTime.Now.AddDays(-1 * monthDay);
                        
                        
                        tbx10StartDate.Tag = eStrartTime.ToString("yyyy/MM/dd");
                        tbx10EndDate.Tag = DateTime.Now.ToString("yyyy/MM/dd");

                        tbx10StartDate.Content = eStrartTime.ToString("MM/dd");
                        tbx10EndDate.Content = DateTime.Now.ToString("MM/dd");
                        

                        CreateEnergyChart(eStrartTime.ToString("yyyyMMdd"), DateTime.Now.ToString("yyyyMMdd"), chart_month);
                        break;
                }
            }
            catch (Exception ee) {
                LogUtil.error("displayPage error：" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 初始化页面切换图片左边距
        /// </summary>
        private void initPageTabImageLeft()
        {
            try
            {
                if (displayPages.Count() > 0)
                {
                    //第一页图片
                    Thickness margin = new Thickness(imageChange1.Margin.Left + offsetPx, imageChange1.Margin.Top, imageChange1.Margin.Right, imageChange1.Margin.Bottom);
                    imageChange1.Margin = margin;
                }
                //第二页图片
                if (displayPages.Count() > 1)
                {
                    Thickness margin = new Thickness(imageChange2.Margin.Left + offsetPx, imageChange2.Margin.Top, imageChange2.Margin.Right, imageChange2.Margin.Bottom);
                    imageChange2.Margin = margin;
                }
                //第三页图片
                if (displayPages.Count() > 2)
                {
                    Thickness margin = new Thickness(imageChange3.Margin.Left + offsetPx, imageChange3.Margin.Top, imageChange3.Margin.Right, imageChange3.Margin.Bottom);
                    imageChange3.Margin = margin;
                }
                //第四页图片
                if (displayPages.Count() > 3)
                {
                    Thickness margin = new Thickness(imageChange4.Margin.Left + offsetPx, imageChange4.Margin.Top, imageChange4.Margin.Right, imageChange4.Margin.Bottom);
                    imageChange4.Margin = margin;
                }
            }
            catch (Exception ee)
            {
                LogUtil.error("initPageTabImageLeft error：" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 初始化页面切换图片
        /// </summary>
        private void initPageTabImage()
        {
            try
            {
                string currentDirectory = System.Environment.CurrentDirectory;
                string nobgName = "szbg021.png";
                string path = currentDirectory + "/Resources/Images/{0}";
                Uri url2 = new Uri(string.Format(path, nobgName));
                if (displayPages.Count() > 0)
                {
                    //第一页图片
                    imageChange1.Source = new BitmapImage(url2);
                    imageChange1.Visibility = Visibility.Visible;
                }
                //第二页图片
                if (displayPages.Count() > 1)
                {
                    path = currentDirectory + "/Resources/Images/{0}";
                    url2 = new Uri(string.Format(path, nobgName));
                    imageChange2.Source = new BitmapImage(url2);
                    imageChange2.Visibility = Visibility.Visible;
                }
                //第三页图片
                if (displayPages.Count() > 2)
                {
                    path = currentDirectory + "/Resources/Images/{0}";
                    url2 = new Uri(string.Format(path, nobgName));
                    imageChange3.Source = new BitmapImage(url2);
                    imageChange3.Visibility = Visibility.Visible;
                }
                //第四页图片
                if (displayPages.Count() > 3)
                {
                    path = currentDirectory + "/Resources/Images/{0}";
                    url2 = new Uri(string.Format(path, nobgName));
                    imageChange4.Source = new BitmapImage(url2);
                    imageChange4.Visibility = Visibility.Visible;
                }
            }
            catch (Exception ee)
            {
                LogUtil.error("initPageTabImage error：" + ee.StackTrace);
            }
        }
        /// <summary>
        /// 改变tab点的背景图片
        /// </summary>
        /// <param name="i"></param>
        private void changeCurDotbg(int pageIndex)
        {
            try
            {
                initPageTabImage();

                string currentDirectory = System.Environment.CurrentDirectory;
                string path = currentDirectory + "/Resources/Images/{0}";
                string bgname = "";
                Uri url2 = null;
                if (pageIndex == 0)
                {
                    bgname = "szbg001.png";
                    url2 = new Uri(string.Format(path, bgname));
                    imageChange1.Source = new BitmapImage(url2);
                }
                else if (pageIndex == 1)
                {
                    bgname = "szbg002.png";
                    url2 = new Uri(string.Format(path, bgname));
                    imageChange2.Source = new BitmapImage(url2);
                }
                else if (pageIndex == 2)
                {
                    bgname = "szbg003.png";
                    url2 = new Uri(string.Format(path, bgname));
                    imageChange3.Source = new BitmapImage(url2);

                }
                else if (pageIndex == 3)
                {
                    bgname = "szbg004.png";
                    url2 = new Uri(string.Format(path, bgname));
                    imageChange4.Source = new BitmapImage(url2);
                }
            }
            catch (Exception ee)
            {
                LogUtil.error("changeCurDotbg error：" + ee.StackTrace);
            }
        }

        ///// <summary>
        ///// 按钮手势开始
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        private void button_ManipulationStarting(object sender, ManipulationStartingEventArgs e)
        {
            e.ManipulationContainer = detailWindow;
            e.Mode = ManipulationModes.All;
        }

        /// <summary>
        /// 按钮手势操作
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button_ManipulationDelta(object sender, ManipulationDeltaEventArgs e)
        {
            FrameworkElement element = (FrameworkElement)e.Source;
            element.Opacity = 0.8;

            Matrix matrix = ((MatrixTransform)element.RenderTransform).Matrix;

            var deltaManipulation = e.DeltaManipulation;

            Point center = new Point(element.ActualWidth / 2, element.ActualHeight / 2);
            center = matrix.Transform(center);

            matrix.ScaleAt(deltaManipulation.Scale.X, deltaManipulation.Scale.Y, center.X, center.Y);
            //this.Width = this.Width + deltaManipulation.Scale.X;
            //this.Height = this.Height + deltaManipulation.Scale.Y;
            matrix.RotateAt(e.DeltaManipulation.Rotation, center.X, center.Y);

            matrix.Translate(e.DeltaManipulation.Translation.X, e.DeltaManipulation.Translation.Y);

            ((MatrixTransform)element.RenderTransform).Matrix = matrix;
            Console.WriteLine("scrae" + deltaManipulation.Scale.X + "-" + deltaManipulation.Scale.Y);
        }

        /// <summary>
        /// 按钮手势操作结束
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button_ManipulationCompleted(object sender, ManipulationCompletedEventArgs e)
        {
            FrameworkElement element = (FrameworkElement)e.Source;
            element.Opacity = 1;
        }

        private void LayoutRoot_MouseDown(object sender, MouseButtonEventArgs e)
        {
            LogUtil.debug("LayoutRoot_MouseDown down");
            stoptimer();

            sendCmdMessage("isdetailclick");
        }


        /// <summary>
        /// 发送到其他窗体的命令
        /// </summary>
        /// <param name="message"></param>
        private void sendCmdMessage(string message)
        {
            LogUtil.debug("sendCmdMessage :"+message);
            //int WINDOW_HANDLER = 1969752;//NativeMethods.FindWindow(null,@"接收方窗体"); 
            string path = (string.IsNullOrEmpty(isDebug) || isDebug.Equals("false")) ? Environment.CurrentDirectory : ConfigurationManager.AppSettings["demo_config_file"];

            int WINDOW_HANDLER = int.Parse(FileUtil.ReadFile(path + "\\demojb.txt"));
            //MessageBox.Show("demo WINDOW_HANDLER：" + WINDOW_HANDLER);
            if (WINDOW_HANDLER > 0)
            {
                byte[] sarr = System.Text.Encoding.Default.GetBytes(message);
                int len = sarr.Length;
                COPYDATASTRUCT cds;
                cds.dwData = (IntPtr)100;
                cds.lpData = message;
                cds.cbData = len + 1;
                NativeMethods.SendMessage(WINDOW_HANDLER, NativeMethods.WM_COPYDATA, 0, ref   cds);
            }
        }

        private void LayoutRoot_TouchDown(object sender, TouchEventArgs e)
        {
            LogUtil.debug("LayoutRoot_TouchDown down");
            sendCmdMessage("isdetailclick");
        }

        private void LayoutRoot_TouchMove(object sender, TouchEventArgs e)
        {
            LogUtil.debug("LayoutRoot_TouchMove down");
            stoptimer();
            sendCmdMessage("isdetailclick");
        }

        private void Ellipse_TouchDown(object sender, TouchEventArgs e)
        {
            LogUtil.debug("Ellipse_TouchDown down");
            this.Close();
        }

        private void Image_ImageFailed(object sender, ExceptionRoutedEventArgs e)
        {
            LogUtil.debug("Image_ImageFailed down");
            this.Close();
        }

        /// <summary>
        /// 添加数据对应图片
        /// </summary>
        /// <param name="canva"></param>
        /// <param name="array"></param>
        /// <param name="tleft"></param>
        private void AddDataImage(Canvas canva, IList<string> array, out double tleft)
        {
            int i = 0;
            tleft = 0;
            try
            {
                string path = System.Environment.CurrentDirectory + "/Resources/Images/01/sz/{0}.png";
                foreach (string s in array)
                {
                    Uri url = new Uri(string.Format(path, s));
                    BitmapImage bmp = new BitmapImage(url);
                    Image img = new Image();
                    img.Width = 19;
                    img.Height = 34;
                    img.Source = bmp;
                    Canvas.SetLeft(img, tleft);
                    canva.Children.Add(img);
                    i++;
                    tleft += img.Width;
                }
            }
            catch (Exception ee)
            {
                LogUtil.error("AddDataImage error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 添加单位对应图片
        /// </summary>
        /// <param name="canva"></param>
        /// <param name="str"></param>
        /// <param name="left"></param>
        private void AddUnitImage(Canvas canva, string str, double left)
        {
            try
            {
                if (str.Equals("W/㎡")) str = "W㎡";
                left += 10;
                string path = System.Environment.CurrentDirectory + "/Resources/Images/01/sz/{0}.png";
                Uri url = new Uri(string.Format(path, str));
                BitmapImage bmp = new BitmapImage(url);
                Image img = new Image();
                img.Height = 36;
                img.Source = bmp;
                Canvas.SetLeft(img, left);
                canva.Children.Add(img);
            }
            catch (Exception ee)
            {
                LogUtil.error("AddUnitImage error:" + ee.StackTrace);
            }
        }

        public void CreatePowerChart(string startDate, string endDate)
        {
            try
            {
                #region 功率图表处理
                string chartTitle = string.Empty;
                string unit = string.Empty;
                ChartData chartData = null;
                try
                {
                    chartData = DataUtil.getPowerData(this.plantId, startDate, endDate);
                    if (chartData == null)
                    {
                        gidPowerChartContainer.Children.Clear();
                        Label l = new Label();
                        l.Content = "无数据";
                        l.HorizontalAlignment = HorizontalAlignment.Center;
                        l.VerticalAlignment = VerticalAlignment.Center;
                        l.FontSize = 48;
                        gidPowerChartContainer.Children.Add(l);
                        return;
                    }
                }
                catch (Exception e2)
                {
                    Console.WriteLine(e2.StackTrace);
                    gidPowerChartContainer.Children.Clear();
                    Label l = new Label();
                    l.Content = "无数据";
                    l.HorizontalAlignment = HorizontalAlignment.Center;
                    l.VerticalAlignment = VerticalAlignment.Center;
                    l.FontSize = 48;
                    gidPowerChartContainer.Children.Add(l);
                    return;
                }

                Chart chart = new Chart();
                ColorSet cs = new ColorSet();
                cs.Brushes.Add(new SolidColorBrush(Color.FromArgb(240, 252, 101, 6)));
                cs.Id = "colorSet1";
                chart.ColorSets.Add(cs);
                chart.ColorSet = "colorSet1";
                chart.BorderBrush = new SolidColorBrush(Color.FromArgb(155, 0, 0, 0));
                chart.Background = new SolidColorBrush(Color.FromArgb(1, 255, 255, 255));
                chart.View3D = false;
                chart.ScrollingEnabled = false;
                chart.CornerRadius = new CornerRadius(30);
                Title title = new Title();
                chart.Titles.Add(title);
                Axis axisX = new Axis();
                axisX.IntervalType = IntervalTypes.Number;
                axisX.Interval = 24;
                axisX.FontSize = 20;
                AxisLabels labels = new AxisLabels();
                axisX.AxisLabels = labels;
                labels.Angle = -45;
                labels.FontSize = 22;
                chart.AxesX.Add(axisX);

                Axis axisY = new Axis();
                axisY.Title = "kW";
                axisY.FontSize = 22;
                axisY.AxisMinimum = 0;
                axisY.TitleFontSize = 20;
                axisY.AxisType = AxisTypes.Primary;

                Axis axisY2 = new Axis();
                axisY2.Title = "W/㎡";
                axisY2.FontSize = 22;
                axisY2.TitleFontSize = 20;
                axisY2.AxisMinimum = 0;
                axisY2.ValueFormatString = "0";
                axisY2.AxisType = AxisTypes.Secondary;

                labels = new AxisLabels();
                labels.FontSize = 22;
                axisY.AxisLabels = labels;
                chart.AxesY.Add(axisY);

                labels = new AxisLabels();
                labels.FontSize = 22;
                axisY2.AxisLabels = labels;
                chart.AxesY.Add(axisY2);


                Legend legend1 = new Legend();
                legend1.FontSize = 14;
                chart.Legends.Add(legend1);

                DataSeries dataSeries = new DataSeries();
                dataSeries.RenderAs = RenderAs.Area;
                dataSeries.XValueType = ChartValueTypes.Auto;
                DataPoint dataPoint;
                dataSeries.AxisYType = AxisTypes.Primary;
                dataSeries.LegendText = chartData.series[0].name;
                for (int i = 0; i < chartData.series[0].data.Count(); i++)
                {
                    dataPoint = new DataPoint();
                    //dataPoint.YValue = chartData.series[0].data[i] == null ? 0 : chartData.series[0].data[i].Value;
                    if (chartData.series[0].data[i] != null)
                        dataPoint.YValue = chartData.series[0].data[i].Value;
                    dataPoint.AxisXLabel = chartData.categories[i];
                    dataSeries.DataPoints.Add(dataPoint);
                }

                chart.Series.Add(dataSeries);
                //if(chartData.series)
                DataSeries dataSunSeries = new DataSeries();
                dataSunSeries.RenderAs = RenderAs.QuickLine;
                dataSunSeries.XValueType = ChartValueTypes.Auto;
                DataPoint sundataPoint;
                dataSunSeries.AxisYType = AxisTypes.Secondary;
                dataSunSeries.LegendText = chartData.series[1].name;
                dataSunSeries.Color = new SolidColorBrush(Color.FromRgb(23, 118, 184));
                dataSunSeries.LineThickness = 2;
                for (int i = 0; i < chartData.series[1].data.Count(); i++)
                {
                    sundataPoint = new DataPoint();
                    if (chartData.series[1].data[i] != null)
                        sundataPoint.YValue = chartData.series[1].data[i].Value;
                    //sundataPoint.AxisXLabel = chartData.categories[i];
                    dataSunSeries.DataPoints.Add(sundataPoint);
                }
                chart.Series.Add(dataSunSeries);
                double maxValue = dataSunSeries.DataPoints.Max(m => m.YValue);
                if (maxValue < 7 || maxValue.Equals(double.NaN))
                {
                    axisY2.AxisMaximum = 0;
                    axisY2.AxisMaximum = 7;
                    axisY2.Interval = 1;
                }
                gidPowerChartContainer.Children.Clear();
                gidPowerChartContainer.Children.Add(chart);
                #endregion
            }
            catch (Exception ee)
            {
                LogUtil.error("CreatePowerChart error:" + ee.StackTrace);
                throw ee;
            }
        }

        /// <summary>
        /// 绘制发电量图表
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="type">1:week 2:month</param>
        public void CreateEnergyChart(string startDate, string endDate, int type)
        {
            try
            {
                columnWidth = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? 2 : 5;
                float maxValue = 0f;
                #region 发电量图表显示
                string chartTitle = string.Empty;
                string unit = string.Empty;
                string startDateStr = string.Format("{0}-{1}-{2}", startDate.Substring(0, 4), startDate.Substring(4, 2), startDate.Substring(6, 2));

                DateTime startDateTime = DateTime.Parse(startDateStr);
                IList<KeyValuePair<string, float?>> energyChartData;
                try
                {
                    energyChartData = DataUtil.getEnergyData(this.plantId, startDate, endDate, chartTitle, unit, out maxValue);
                    if (energyChartData == null)
                    {
                        gidEnergyChartContainer.Children.Clear();
                        Label l = new Label();
                        l.Content = "无数据";
                        l.HorizontalAlignment = HorizontalAlignment.Center;
                        l.VerticalAlignment = VerticalAlignment.Center;
                        l.FontSize = 48;
                        gidEnergyChartContainer.Children.Add(l);
                        return;
                    }
                }
                catch (Exception e2)
                {
                    Console.WriteLine(e2.Message);
                    gidEnergyChartContainer.Children.Clear();
                    Label l = new Label();
                    l.Content = "无数据";
                    l.HorizontalAlignment = HorizontalAlignment.Center;
                    l.VerticalAlignment = VerticalAlignment.Center;
                    l.FontSize = 48;
                    gidEnergyChartContainer.Children.Add(l);
                    return;
                }
                Chart energyChart = new Chart();
                ColorSet cs = new ColorSet();
                cs.Brushes.Add(new SolidColorBrush(Color.FromArgb(240, 252, 101, 6)));
                cs.Id = "colorSet1";

                energyChart.ColorSets.Add(cs);
                energyChart.ColorSet = "colorSet1";
                energyChart.BorderBrush = new SolidColorBrush(Color.FromArgb(155, 0, 0, 0));
                energyChart.Background = new SolidColorBrush(Color.FromArgb(1, 255, 255, 255));

                energyChart.View3D = false;
                energyChart.ScrollingEnabled = false;
                energyChart.CornerRadius = new CornerRadius(30);
                Title energTitle = new Title();
                energTitle.FontSize = 22;
                energyChart.Titles.Add(energTitle);
                Axis eaxis = new Axis();
                eaxis.IntervalType = IntervalTypes.Number;
                if (type == 2)
                    eaxis.Interval = 2;
                eaxis.TitleFontSize = 22;
                eaxis.FontSize = 22;

                AxisLabels elabels = new AxisLabels();
                elabels.FontSize = 22;
                eaxis.AxisLabels = elabels;

                elabels.Angle = -45;
                energyChart.AxesX.Add(eaxis);

                Axis eaxisY = new Axis();
                eaxisY.Title = "kWh";
                eaxisY.FontSize = 24;
                eaxisY.TitleFontSize = 22;
                elabels = new AxisLabels();
                elabels.FontSize = 22;
                eaxisY.AxisLabels = elabels;
                energyChart.AxesY.Add(eaxisY);

                DataSeries edataSeries = new DataSeries();
                edataSeries.RenderAs = RenderAs.Column;
                edataSeries.XValueType = ChartValueTypes.Auto;
                DataPoint edataPoint;
                double percent20 = maxValue * 0.02;
                for (int i = 0; i < energyChartData.Count; i++)
                {
                    edataPoint = new DataPoint();
                    edataPoint.AxisXLabel = startDateTime.AddDays(i).ToString("yy/MM/dd");
                    edataPoint.XValue = i;
                    edataPoint.YValue = (double)energyChartData[i].Value;
                    edataPoint.ToolTipText = string.Format("{0},{1}", edataPoint.AxisXLabel, energyChartData[i].Value);
                    if (edataPoint.YValue < percent20 && edataPoint.YValue > 0)
                        edataPoint.YValue = percent20;
                    edataSeries.DataPoints.Add(edataPoint);
                }
                energyChart.DataPointWidth = columnWidth;
                energyChart.Series.Add(edataSeries);
                gidEnergyChartContainer.Children.Clear();
                gidEnergyChartContainer.Children.Add(energyChart);
                #endregion
            }
            catch (Exception ee)
            {
                LogUtil.error("CreateEnergyChart error:" + ee.StackTrace);
                throw ee;
            }
        }

        /// <summary>
        /// 影藏功率图表
        /// </summary>
        public void hiddenPowerChart()
        {
            gidPowerGrid.Visibility = Visibility.Hidden;
        }

        /// <summary>
        /// 显示功率图表
        /// </summary>
        public void displayPowerChart()
        {
            gidPowerGrid.Visibility = Visibility.Visible;
        }

        /// <summary>
        /// 加载窗体数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void detailWindow_Loaded(object sender, RoutedEventArgs e)
        {
            if (isdebug)
            {
                loadData();
                changesize();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        public void loadData()
        {
            PlantVO pvo = DataUtil.getPlantInfo(this.plantId);
            try
            {
                BitmapImage bmp = DataUtil.loadPlantImg(this.plantId, pvo.imageArray);
                imgPlant.Source = bmp;
                imgPlant.Width = 300;
                imgPlant.Height = 216;

                imgPlant.Visibility = Visibility.Visible;
                this.lblPlantName.Content = pvo.plantName;

                //this.tbxEndDate.Content = this.tbx10EndDate.Content = DateTime.Now.ToString("yyyy/MM/dd");
                //this.tbxStartDate.Content = DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
                //this.tbx10StartDate.Content = DateTime.Now.AddDays(-1 * lastDay).ToString("yyyy/MM/dd");

                double tleft = 0;
                AddDataImage(imageCanvas, DataStrUtil.AnalData(pvo.solarIntensity), out tleft);
                AddUnitImage(imageCanvas, "W㎡", tleft);

                AddDataImage(tmCanvas, DataStrUtil.AnalData(pvo.temprature), out tleft);
                AddUnitImage(tmCanvas, pvo.tempratureUnit, tleft);

                AddDataImage(curPowerCanvas, DataStrUtil.AnalData(pvo.curPower), out tleft);
                AddUnitImage(curPowerCanvas, (pvo.curPowerUnit), tleft);

                AddDataImage(co2Canvas, DataStrUtil.AnalData(pvo.CQ2reduce), out tleft);
                AddUnitImage(co2Canvas, (pvo.CQ2reduceUnit), tleft);

                AddDataImage(todayEnCanvas, DataStrUtil.AnalData(pvo.dayEnergy), out tleft);
                AddUnitImage(todayEnCanvas, (pvo.dayEnergyUnit), tleft);

                AddDataImage(ttlEnCanvas, DataStrUtil.AnalData(pvo.totalEnergy), out tleft);
                AddUnitImage(ttlEnCanvas, (pvo.totalEnergyUnit), tleft);

                this.lblinstallData.Content = pvo.installDate;
                this.lblDesignPower.Content = pvo.DesignPower;
                this.lblLocation.Content = pvo.organize;
                this.lblStreet.Content = pvo.City + "," + pvo.Country;

                this.lblinverterCount.Content = pvo.inverterCount;
                this.lblinvertertypeStr.Text = pvo.inverterTypeStr;
            }
            catch (Exception ee)
            {
                LogUtil.error("loadData error:" + ee.StackTrace);
                //throw ee;
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tbxStartDate_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try{
               // calStartDate.SelectedDate = DateTime.Parse(tbxStartDate.Content.ToString());
                calStartDate.SelectedDate = DateTime.Parse(tbxStartDate.Tag.ToString());
                calStartDate.Visibility = System.Windows.Visibility.Visible;
            }catch(Exception ee){
                LogUtil.error("tbxStartDate_MouseDown error:" + ee.StackTrace);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tbxStartDate_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            try{
                calStartDate.Visibility = System.Windows.Visibility.Visible;
            }catch(Exception ee){
                LogUtil.error("tbxStartDate_MouseDoubleClick error:" + ee.StackTrace);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tbxStartDate_GotFocus(object sender, RoutedEventArgs e)
        {
            try{
                calStartDate.Visibility = System.Windows.Visibility.Visible;
                calEndDate.Visibility = System.Windows.Visibility.Hidden;
            }catch(Exception ee){
                LogUtil.error("tbxStartDate_GotFocus error:" + ee.StackTrace);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void textBox2_GotFocus(object sender, RoutedEventArgs e)
        {
            try{
                //calEndDate.SelectedDate = DateTime.Parse(tbxEndDate.Content.ToString());
                calEndDate.SelectedDate = DateTime.Parse(tbxEndDate.Tag.ToString());

                calStartDate.Visibility = System.Windows.Visibility.Hidden;
                calEndDate.Visibility = System.Windows.Visibility.Visible;
            }catch(Exception ee){
                LogUtil.error("textBox2_GotFocus error:" + ee.StackTrace);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void calEndDate_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try{
                DateTime endTime = (DateTime)calEndDate.SelectedDate;
                DateTime startTime = endTime.AddDays(-1);
                
                tbxEndDate.Tag = endTime.ToString("yyyy/MM/dd");
                tbxEndDate.Content = endTime.ToString("MM/dd");

                calEndDate.Visibility = System.Windows.Visibility.Hidden;
                
                tbxStartDate.Content = startTime.ToString("MM/dd");
                tbxStartDate.Tag = startTime.ToString("yyyy/MM/dd");
                
                lblPowerDate1.Content = this.formatDate(startTime);// tbxStartDate.Content;
                lblPowerDate2.Content = this.formatDate(endTime);// tbxEndDate.Content;
                CreatePowerChart(startTime.ToString("yyyyMMdd00"), endTime.AddDays(1).ToString("yyyyMMdd23"));
            }catch(Exception ee){
                LogUtil.error("calEndDate_MouseDown error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        private void tbx10StartDate_MouseDown(object sender, MouseButtonEventArgs e)
        {
        }
        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tbx10StartDate_GotFocus(object sender, RoutedEventArgs e)
        {
            try{
                cal10Start.Visibility = System.Windows.Visibility.Visible;
                cal10End.Visibility = System.Windows.Visibility.Hidden;
            }catch(Exception ee){
                LogUtil.error("tbx10StartDate_GotFocus error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void tbx10EndDate_GotFocus(object sender, RoutedEventArgs e)
        {
            try{
                cal10Start.Visibility = System.Windows.Visibility.Hidden;
                cal10End.Visibility = System.Windows.Visibility.Visible;
            }catch(Exception ee){
                LogUtil.error("tbx10EndDate_GotFocus error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cal10Start_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try{
                DateTime selectedTime = (DateTime)cal10Start.SelectedDate;
                
                tbx10StartDate.Tag = selectedTime.ToString("yyyy/MM/dd");
                tbx10StartDate.Content = selectedTime.ToString("MM/dd");
                
                cal10Start.Visibility = System.Windows.Visibility.Hidden;
                int lastDay = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? monthDay : weekDay;
                int charttype = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? chart_month : chart_week;
                tbx10EndDate.Tag = selectedTime.AddDays(1 * lastDay).ToString("yyyy/MM/dd");
                tbx10EndDate.Content = selectedTime.AddDays(1 * lastDay).ToString("MM/dd");

                CreateEnergyChart(selectedTime.ToString("yyyyMMdd"), selectedTime.AddDays(1 * lastDay).ToString("yyyyMMdd"), charttype);
            }catch(Exception ee){
                LogUtil.error("cal10Start_MouseDown error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 次方法在detail页面废弃
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cal10End_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try{
                DateTime selectedTime = (DateTime)cal10End.SelectedDate;
                tbx10EndDate.Content = selectedTime.ToString("MM/dd");
                tbx10EndDate.Tag = selectedTime.ToString("yyyy/MM/dd");

                cal10End.Visibility = System.Windows.Visibility.Hidden;
                int lastDay = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? monthDay : weekDay;
                int charttype = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? chart_month : chart_week;
                
                tbx10StartDate.Content = selectedTime.AddDays(-1 * lastDay).ToString("MM/dd");
                tbx10StartDate.Tag = selectedTime.AddDays(-1 * lastDay).ToString("yyyy/MM/dd");

                CreateEnergyChart(selectedTime.AddDays(-1 * lastDay).ToString("yyyyMMdd"), selectedTime.ToString("yyyyMMdd"),charttype);
            }catch(Exception ee){
                LogUtil.error("cal10End_MouseDown error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }

        private void imgPlant_ManipulationStarting(object sender, ManipulationStartingEventArgs e)
        {
        }

        private void ChangePowerChartDate(string endDate)
        {
            try{
                DateTime endDateTime = DateTime.Parse(endDate);
                DateTime startDateTime = endDateTime.AddDays(-1);
                
                this.tbxStartDate.Content = startDateTime.ToString("MM/dd");
                this.tbxStartDate.Tag = startDateTime.ToString("yyyy/MM/dd");

                this.tbxEndDate.Content = endDateTime.ToString("MM/dd");
                this.tbxEndDate.Tag = endDateTime.ToString("yyyy/MM/dd");

                lblPowerDate1.Content = formatDate(startDateTime);// tbxStartDate.Content;
                lblPowerDate2.Content = formatDate(endDateTime);// tbxEndDate.Content;
                CreatePowerChart(startDateTime.ToString("yyyyMMdd00"), endDateTime.ToString("yyyyMMdd23"));
            }catch(Exception ee){
                LogUtil.error("ChangePowerChartDate error:" + ee.Message);
            }finally{
               stoptimer();
               sendCmdMessage("isdetailclick");
            }
        }
        /// <summary>
        /// 格式化时间，返回今日和昨日的中文，其他时间原值返回
        /// </summary>
        /// <param name="aimdate"></param>
        /// <returns></returns>
        private string formatDate(DateTime aimdate)
        {
            try{
                string aim = CalenderUtil.formatDate(aimdate, "yyyy/MM/dd");
                string today = CalenderUtil.formatDate(DateTime.Now, "yyyy/MM/dd");
                if (aim.Equals(today))
                {
                    string masterLangText = App.Current.FindResource(string.Format("{0}_ChartToday", masterlang)).ToString();
                    string childLangText = App.Current.FindResource(string.Format("{0}_ChartToday", childlang)).ToString();
                    return string.Format("{0}({1})", masterLangText, childLangText);
                }
                else
                {
                    string last = CalenderUtil.formatDate(DateTime.Now.AddDays(-1), "yyyy/MM/dd");
                    if (aim.Equals(last))
                    {
                        string masterLangText = App.Current.FindResource(string.Format("{0}_ChartYesterday", masterlang)).ToString();
                        string childLangText = App.Current.FindResource(string.Format("{0}_ChartYesterday", childlang)).ToString();
                        return string.Format("{0}({1})", masterLangText, childLangText);
                    }
                    else
                    {
                        return aim;
                    }
                }
            }catch(Exception ee){
                LogUtil.error("formatDate error:" + ee.Message);
                return CalenderUtil.formatDate(aimdate, "yyyy/MM/dd");
            }
        }

        private void ChangeEnergyChartDate(string endDate)
        {
            try{
                DateTime endDateTime = DateTime.Parse(endDate);
                int lastDay = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? monthDay : weekDay;
                int charttype = curPage == int.Parse(ConfigPara.MonthEnergyChartPage) ? chart_month : chart_week;
                DateTime startDateTime = endDateTime.AddDays(-1 * lastDay);
                
                
                this.tbx10StartDate.Tag = startDateTime.ToString("yyyy/MM/dd");
                this.tbx10EndDate.Tag = endDateTime.ToString("MM/dd");
                this.tbx10StartDate.Content = startDateTime.ToString("yyyy/MM/dd");
                this.tbx10EndDate.Content = endDateTime.ToString("MM/dd");


                CreateEnergyChart(startDateTime.ToString("yyyyMMdd"), endDateTime.ToString("yyyyMMdd"),charttype);
            }catch(Exception ee){
                LogUtil.error("ChangeEnergyChartDate error:" + ee.Message);
            }
        }

        private void imgNext_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            try{
                //DateTime endDateTime = DateTime.Parse(tbxEndDate.Content.ToString());
                DateTime endDateTime = DateTime.Parse(tbxEndDate.Tag.ToString());
                ChangePowerChartDate(endDateTime.AddDays(1).ToString("yyyy/MM/dd"));
            }catch(Exception ee){
                LogUtil.error("imgNext_MouseLeftButtonDown error:" + ee.Message);
            }finally{
                stoptimer();
                sendCmdMessage("isdetailclick");
            }
        }

        private void imgPre_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            try{
                DateTime endDateTime = DateTime.Parse(tbxEndDate.Tag.ToString());
                //DateTime endDateTime = DateTime.Parse(tbxEndDate.Content.ToString());

                ChangePowerChartDate(endDateTime.AddDays(-1).ToString("yyyy/MM/dd"));
            }catch(Exception ee){
                LogUtil.error("imgPre_MouseLeftButtonDown error:" + ee.StackTrace);
            }finally{
                stoptimer();
                sendCmdMessage("isdetailclick");
            }
        }

        private void imgNextEnergy_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            try{
                //DateTime endDateTime = DateTime.Parse(tbx10EndDate.Content.ToString());
                DateTime endDateTime = DateTime.Parse(tbx10EndDate.Tag.ToString());
                ChangeEnergyChartDate(endDateTime.AddDays(1).ToString("yyyy/MM/dd"));
            }catch(Exception ee){
                LogUtil.error("imgNextEnergy_MouseLeftButtonDown error:" + ee.StackTrace);
            }finally{
                stoptimer();
                sendCmdMessage("isdetailclick");
            }
        }

        private void imgPreEnergy_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            try{
                //DateTime endDateTime = DateTime.Parse(tbx10EndDate.Content.ToString());
                DateTime endDateTime = DateTime.Parse(tbx10EndDate.Tag.ToString());

                ChangeEnergyChartDate(endDateTime.AddDays(-1).ToString("yyyy/MM/dd"));
            }catch(Exception ee){
                LogUtil.error("imgPreEnergy_MouseLeftButtonDown error:" + ee.StackTrace);
            }finally{
                stoptimer();
                sendCmdMessage("isdetailclick");
            }
        }

        private void calStartDate_MouseDown(object sender, MouseButtonEventArgs e)
        {
            try{
                DateTime startTime = (DateTime)calStartDate.SelectedDate;
                DateTime endtime = startTime.AddDays(1);
                
                tbxStartDate.Content = startTime.ToString("MM/dd");
                tbxStartDate.Tag = startTime.ToString("yyyy/MM/dd");


                calStartDate.Visibility = System.Windows.Visibility.Hidden;
                
                tbxEndDate.Content = endtime.ToString("MM/dd");
                tbxEndDate.Tag = endtime.ToString("yyyy/MM/dd");

                lblPowerDate1.Content = this.formatDate(startTime);// tbxStartDate.Content;
                lblPowerDate2.Content = this.formatDate(endtime);//.Content;
                CreatePowerChart(startTime.ToString("yyyyMMdd00"), endtime.ToString("yyyyMMdd23"));//发电量图表
            }catch(Exception ee){
                LogUtil.error("calStartDate_MouseDown error:" + ee.StackTrace);
            }finally{
                stoptimer();
                sendCmdMessage("isdetailclick");
            }
        }

        /// <summary>
        /// 返回按钮事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void imgContinue_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            sendCmdMessage("isdetailclick");
            stoptimer();
            this.Close();
        }

        private void tbx10EndDate_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            cal10Start.Visibility = System.Windows.Visibility.Hidden;
            cal10End.Visibility = System.Windows.Visibility.Visible;
            stoptimer();
            sendCmdMessage("isdetailclick");
        }

        private void tbx10StartDate_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            cal10Start.Visibility = System.Windows.Visibility.Visible;
            cal10End.Visibility = System.Windows.Visibility.Hidden;
            stoptimer();
            sendCmdMessage("isdetailclick");
        }

        private void tbxStartDate_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            calStartDate.Visibility = System.Windows.Visibility.Visible;
            calEndDate.Visibility = System.Windows.Visibility.Hidden;
            stoptimer();
            sendCmdMessage("isdetailclick");
        }

        private void tbxEndDate_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            calStartDate.Visibility = System.Windows.Visibility.Hidden;
            calEndDate.Visibility = System.Windows.Visibility.Visible;
            stoptimer();
            sendCmdMessage("isdetailclick");
        }

        /// <summary>
        /// 回首页
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void imgIndex_MouseDown(object sender, MouseButtonEventArgs e)
        {
            stoptimer();
            sendCmdMessage("startindex");
            this.Close();
        }

        private void imageChange1_MouseDown(object sender, MouseButtonEventArgs e)
        {
            displayPage(0);
        }

        private void imageChange2_MouseDown(object sender, MouseButtonEventArgs e)
        {
            displayPage(1);
        }

        private void imageChange3_MouseDown(object sender, MouseButtonEventArgs e)
        {
            displayPage(2);
        }

        private void imageChange4_MouseDown(object sender, MouseButtonEventArgs e)
        {
            displayPage(3);
        }

        private void detailWindow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.F4)//ctrl+s   
            {
                sendCmdMessage("exit");
            }
        }
    }
}