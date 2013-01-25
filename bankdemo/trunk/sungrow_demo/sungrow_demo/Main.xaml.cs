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
using sungrow_touch;
using sungrow_demo.Service.vo;
using sungrow_demo.model;
using sungrow_demo.Service;
using sungrow_demo.Model;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Runtime.InteropServices;

using System.Windows.Threading;
using System.Collections;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
namespace sungrow_demo
{
    /// <summary>
    /// Main.xaml 的交互逻辑
    /// </summary>
    public partial class Main : Window
    {
        string isDebug = System.Configuration.ConfigurationManager.AppSettings["isDebug"];
        List<PlantInfoVo> pvos = null;
        private System.Windows.Forms.NotifyIcon notifyIcon;
        ConfigPara config = ConfigManagerService.GetInstance().LoadConfig();
        public static ControlCenter cc = null;
        static int pageIndex = 1;
        const int PAGESIZE = 10;
        private static string addPids = "|";
        private int startt = 0;
        private bool isStoprun = false;
        public Main()
        {
            InitializeComponent();
            if (isDebug.Equals("false"))
                this.Topmost = true;

            this.notifyIcon = new System.Windows.Forms.NotifyIcon();
            this.notifyIcon.BalloonTipText = "多电站演示系统正在运行！";
            this.notifyIcon.Text = "多电站演示系统！";
            this.notifyIcon.Icon = new System.Drawing.Icon("favicon.ico");
            this.notifyIcon.Visible = true;
            this.notifyIcon.ShowBalloonTip(1000);
            this.notifyIcon.MouseClick += new System.Windows.Forms.MouseEventHandler(notifyIcon_MouseClick);

            System.Windows.Forms.MenuItem showWindow = new System.Windows.Forms.MenuItem("显示界面");
            showWindow.Click += new EventHandler(showWindow_Click);

            System.Windows.Forms.MenuItem exitSystem = new System.Windows.Forms.MenuItem("退出");
            exitSystem.Click += new EventHandler(exitSystem_Click);
            System.Windows.Forms.MenuItem[] menuItems = new System.Windows.Forms.MenuItem[] { showWindow, exitSystem };
            this.notifyIcon.ContextMenu = new System.Windows.Forms.ContextMenu(menuItems);

            this.StateChanged += new EventHandler(MainWindow_StateChanged);

            setHook();

            autoRun();
            //GC.Collect();
            //GC.WaitForPendingFinalizers();
            //GC.Collect();
        }


        private void autoRun()
        {
            //开始倒计时
            DispatcherTimer dt = new DispatcherTimer();
            dt.Interval = TimeSpan.FromSeconds(1);
            dt.Tick += new EventHandler(delegate(object sender, EventArgs e)
            {
                if (isStoprun)
                {
                    dt.Stop();
                    return;
                }

                startt++;
                if (startt == 20)
                {
                    dt.Stop();
                    startDemo();
                    isStoprun = true;
                }
            });//调用函数
            dt.Start();
        }

        void MainWindow_StateChanged(object sender, EventArgs e)
        {
            if (this.WindowState == WindowState.Minimized)
            {
                this.Visibility = Visibility.Hidden;
            }
        }

        /// <summary>
        /// 只用来判断是否有人为介入
        /// </summary>
        private void setHook()
        {
            //设置键盘钩子
            //this.StartHook();
            //MessageBox.Show(this.hookID.ToString());
        }

        /// <summary>
        /// 键盘钩子。鼠标单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void delelate_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            //ctrl+S保存 
            if (e.KeyCode == System.Windows.Forms.Keys.F4)//ctrl+s   
            {
                this.notifyIcon.Visible = false;
                //先kill
                SystemUtil.KillProcess("sungrow_touch");

                //先清理资源再退出程序
                if (cc != null) cc.clear();
                //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
                //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
                //geProcess.Kill();
                this.Close();

                Environment.Exit(0);
            }
        }


        /// <summary>
        /// 显示配置界面
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void showWindow_Click(object sender, EventArgs e)
        {
            this.Topmost = true;
            //中断系统运行
            ControlCenter.pauseTime = DateTime.Now;
            ControlCenter.isPause = true;
            this.Visibility = Visibility.Visible;
            this.Activate();
            this.Show();
        }

        /// <summary>
        /// 退出系统
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void exitSystem_Click(object sender, EventArgs e)
        {
            //if (MessageBox.Show("确定要退出多电站演示系统吗？",
            //                      "多电站演示系统",
            //                      MessageBoxButton.YesNo,
            //                      MessageBoxImage.Question,
            //                      MessageBoxResult.No) == MessageBoxResult.Yes)
            //{
            this.notifyIcon.Visible = false;
            //先kill
            SystemUtil.KillProcess("sungrow_touch");

            //先清理资源再推出程序
            if (cc != null) cc.clear();
            //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
            //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
            //geProcess.Kill();
            this.Close();

            Environment.Exit(0);
            //}
        }

        void notifyIcon_MouseClick(object sender, System.Windows.Forms.MouseEventArgs e)
        {
            if (e.Button == System.Windows.Forms.MouseButtons.Left)
            {
                if (this.Visibility == Visibility.Visible)
                {
                    this.Visibility = Visibility.Hidden;
                }
                else
                {
                    this.Visibility = Visibility.Visible;
                    this.Activate();
                }
            }
        }

        /// <summary>
        /// 最小化窗口
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void imgSmall_MouseUp(object sender, MouseButtonEventArgs e)
        {
            this.WindowState = WindowState.Minimized;
            ControlCenter.pauseTime = DateTime.Now;
            ControlCenter.isPause = true;
        }

        private void WelcomeWindow_Loaded(object sender, RoutedEventArgs e)
        {
            this.BuildControls(config.PlantsInfo);
            tbxmainpageinterval.Text = config.MainInterval;
            string hycStr = FileUtil.ReadFile(System.Environment.CurrentDirectory + "/text.txt");
            this.tboxhyc.Text = hycStr.Substring(4);
            tbxtipsinterval.Text = config.TipsInterval;
            tbxheight.Text = config.height;
            tbxdetailinterval.Text = config.DetailInterval;
            tboxDomain.Text = config.domain;
            cbxCounterType.SelectedIndex = config.CounterType;
            cbxCurrencyType.SelectedIndex = config.currencyType;
            incomeRate.Text = config.incomeRate.ToString("0.00");
            tboxSysname.Text = config.sysname;

            string[] cboxNames = null;
            if (string.IsNullOrEmpty(config.displayItems) == false)
                cboxNames = config.displayItems.Split('|').ToArray<string>();
            else
                cboxNames = new string[] { };
            #region 拉取显示项目
            foreach (UIElement ui in displayItems.Children)
            {
                foreach (string cboxName in cboxNames)
                {
                    if (string.IsNullOrEmpty(cboxName))
                        continue;
                    if ((ui is CheckBox) && (ui as CheckBox).Name.Equals(ConfigPara.displayItemsName[int.Parse(cboxName)]))
                    {
                        (ui as CheckBox).IsChecked = true;
                        break;
                    }
                }
            }
            #endregion

            if (string.IsNullOrEmpty(config.displayPages) == false)
                cboxNames = config.displayPages.Split('|').ToArray<string>();
            else
                cboxNames = new string[] { };
            #region 拉取显示页面配置项目
            foreach (UIElement ui in displayPages.Children)
            {
                foreach (string cboxName in cboxNames)
                {
                    if (string.IsNullOrEmpty(cboxName))
                        continue;
                    if ((ui is CheckBox) && (ui as CheckBox).Name.Equals(ConfigPara.displayPageName[int.Parse(cboxName)]))
                    {
                        (ui as CheckBox).IsChecked = true;
                        break;
                    }
                }
            }
            #endregion

            #region 语言绑定
            ArrayList array = new ArrayList();
            for (int i = LangUtil.Languages.Count; --i >= 0; )
            {
                if ((LangUtil.Languages[i] as Language).code.Equals(LangUtil.EN))
                {
                    continue;
                }
                array.Add(LangUtil.Languages[i]);
            }
            cbxMasterLanguage.ItemsSource = array;
            cbxMasterLanguage.DisplayMemberPath = "name";
            cbxMasterLanguage.SelectedValuePath = "code";

            array = new ArrayList();
            for (int i = LangUtil.Languages.Count; --i >= 0; )
            {
                if ((LangUtil.Languages[i] as Language).code.Equals(LangUtil.Zh))
                {
                    continue;
                }
                array.Add(LangUtil.Languages[i]);
            }

            cbxMasterLanguage.SelectedIndex = 0;
            cbxLanguage.ItemsSource = array;
            cbxLanguage.DisplayMemberPath = "name";
            cbxLanguage.SelectedValuePath = "code";
            cbxLanguage.SelectedIndex = 0;
            #endregion

        }

        /// <summary>
        /// 保存配置
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSave_Click(object sender, RoutedEventArgs e)
        {
            SaveConfig();
        }

        private string findTextBox(string controlName)
        {
            foreach (UIElement c in plantsList.Children)
            {
                if (c is TextBox && (c as TextBox).Name.Equals(controlName))
                    return (c as TextBox).Text;
            }
            return string.Empty;
        }

        private List<CheckBox> findCheckBox(Grid parentControl, bool check)
        {
            List<CheckBox> checkBoxes = new List<CheckBox>();
            foreach (UIElement c in parentControl.Children)
            {
                if (c is CheckBox && (c as CheckBox).IsChecked == check)
                    checkBoxes.Add((CheckBox)c);
            }
            return checkBoxes;
        }
        private void SaveConfig()
        {
            if (Regex.IsMatch(tbxheight.Text, "^\\d+$") == false)
            {
                MessageBox.Show("高度只能是数字格式");
                return;
            }
            if (Regex.IsMatch(tbxtipsinterval.Text, "^\\d+$") == false)
            {
                MessageBox.Show("气泡显示时长只能是数字格式");
                return;
            }

            if (Regex.IsMatch(tbxdetailinterval.Text, "^\\d+$") == false)
            {
                MessageBox.Show("详细页面显示时长只能是数字格式");
                return;
            }
            if (Regex.IsMatch(tbxmainpageinterval.Text, "^\\d+$") == false)
            {
                MessageBox.Show("首页停留时间只能是数字格式");
                return;
            }
            if (Regex.IsMatch(incomeRate.Text, "^\\d+\\.\\d+$") == false)
            {
                MessageBox.Show("收益转化率只能是小数");
                return;
            }
            List<CheckBox> cboxes = findCheckBox(this.displayItems, true);
            if (cboxes.Count < 4)
            {
                MessageBox.Show("至少需要选择4个首页汇总项目");
                return;
            }
            if (cboxes.Count > 5)
            {
                MessageBox.Show("最多不能超过5个显示首页汇总项目");
                return;
            }

            if (string.IsNullOrEmpty(tboxhyc.Text) == false)
                FileUtil.WriteFile(Environment.CurrentDirectory, "text.txt", string.Format("hyc={0}", tboxhyc.Text));

            config.langInfo = string.Format("{0}-{1}", cbxMasterLanguage.SelectedValue, cbxLanguage.SelectedValue);
            config.MainInterval = tbxmainpageinterval.Text;
            config.domain = tboxDomain.Text;
            config.CounterType = cbxCounterType.SelectedIndex;
            config.currencyType = cbxCurrencyType.SelectedIndex;
            config.CounterUser = tbxUserName.Text;
            string displayItems = string.Empty;
            foreach (CheckBox cbox in cboxes)
                displayItems += string.Format("{0}|", Array.FindIndex(ConfigPara.displayItemsName.ToArray(), i => i.Equals(cbox.Name)));
            config.displayItems = displayItems;
            displayItems = string.Empty;
            cboxes = findCheckBox(displayPages, true);
            if (cboxes.Count < 1)
            {
                MessageBox.Show("至少需要选择1个电站子页面");
                return;
            }
            foreach (CheckBox cbox in cboxes)
                displayItems += string.Format("{0}|", Array.FindIndex(ConfigPara.displayPageName.ToArray(), i => i.Equals(cbox.Name)));
            config.displayPages = displayItems;//显示页面配置
            decimal rate = 0;
            decimal.TryParse(incomeRate.Text, out rate);
            config.incomeRate = rate;
            foreach (PlantInfoVo plantInfoVo in config.PlantsInfo)
            {
                if (!config.height.Equals(tbxheight.Text))
                {
                    plantInfoVo.height = tbxheight.Text;
                }
                if (!config.TipsInterval.Equals(tbxtipsinterval.Text))
                {
                    plantInfoVo.tipInterval = tbxtipsinterval.Text;
                }
                if (!config.DetailInterval.Equals(tbxdetailinterval.Text))
                {
                    plantInfoVo.detailInterval = tbxdetailinterval.Text;
                }
            }

            config.height = tbxheight.Text;
            config.TipsInterval = tbxtipsinterval.Text;
            config.DetailInterval = tbxdetailinterval.Text;
            if (config.CounterType == ConfigPara.currentUser)
            {
                if (string.IsNullOrEmpty(config.CounterUser))
                {
                    MessageBox.Show("请输入用户名！");
                    tbxUserName.Focus();
                    return;
                }
            }

            config.sysname = tboxSysname.Text;

            // if (selected == 0)
            {
                //展示电站列表
                List<PlantInfoVo> checkedPlants = new List<PlantInfoVo>();
                //
                //List<PlantInfoVo> allPlants = new List<PlantInfoVo>();
                //foreach (UIElement c in plantsList.Children)
                //{
                //    if (c is CheckBox)
                //    {
                //        CheckBox cbox = c as CheckBox;
                //        PlantInfoVo tempVo = config.PlantsInfo.Single(model => string.Format("pid_{0}", model.plantId).Equals(cbox.Name));
                //        tempVo.Longitude = double.Parse(findTextBox(string.Format("tboxlong_{0}", tempVo.plantId)));
                //        tempVo.latitude = double.Parse(findTextBox(string.Format("tboxlat_{0}", tempVo.plantId)));
                //        tempVo.height = findTextBox(string.Format("tboxhei_{0}", tempVo.plantId));
                //        tempVo.design_power = findTextBox(string.Format("tboxdesignpower_{0}", tempVo.plantId));
                //        tempVo.detailInterval = findTextBox(string.Format("tboxdetailtime_{0}", tempVo.plantId));
                //        tempVo.tipInterval = findTextBox(string.Format("tboxtiptime_{0}", tempVo.plantId));
                //        if (cbox.IsChecked == true)
                //        {
                //            checkedPlants.Add(tempVo);
                //        }
                //        allPlants.Add(tempVo);
                //    }

                //}

                string[] pidArray = addPids.Split('|');
                foreach (string pid in pidArray)
                {
                    if (string.IsNullOrEmpty(pid))
                        continue;
                    checkedPlants.Add(config.PlantsInfo.FirstOrDefault(p => p.plantId.Equals(pid)));
                }
                config.TipsPlantsInfo = checkedPlants;
                //config.PlantsInfo = allPlants;
            }

            //if (selected == 1)
            //{
            //自动演示电站列表
            //List<PlantInfoVo> tipscheckedPlants = new List<PlantInfoVo>();
            //for (int x = 0; x < tipsplantsList.Children.Count; x++)
            //{
            //    if (tipsplantsList.Children[x] is CheckBox)
            //    {
            //        CheckBox check = tipsplantsList.Children[x] as CheckBox;
            //        if (check.IsChecked == true)
            //        {
            //            tipscheckedPlants.Add(pvos.Single(model => string.Format("pid_{0}", model.plantId).Equals(check.Name)));
            //        }
            //    }
            //}
            //config.TipsPlantsInfo = tipscheckedPlants;
            //  }

            //保存配置的电站到 KML 文件 plant.kml

            kml kml = new kml();
            List<GroundOverlay> groundoverlaies = new List<GroundOverlay>();
            foreach (PlantInfoVo piv in config.PlantsInfo)
            {
                String desc = "";
                if (config.TipsPlantsInfo != null && config.TipsPlantsInfo.Contains(piv))
                {
                    desc = "<font size=4>装机容量：" + piv.design_power + " kW</font><hr><font size=4>" + "城市：" + piv.city + "</font><br/><font size=4>国家：" + piv.country + "</font><hr><a href='http://localhost:8111/web?plantId=" + piv.plantId + "' target='_self'><font size=4>点击查看详细信息</font></a>";
                }
                else
                {
                    desc = "<font size=4>装机容量：" + piv.design_power + " kW</font><hr><font size=4>" + "城市：" + piv.city + "</font><br/><font size=4>国家：" + piv.country + "</font><hr>";
                }
                kml.Document.Add(new Placemark(piv.plantName, desc, "#globeIcon", "1", new Placemark.KMLPoint(piv.latitude, piv.Longitude, "1", "relativeToGround"), new Placemark.LookAt() { altitude = "0", heading = "137.6356988109601", latitude = "-152.6659616588421", longitude = "-152.6659616588421", range = "334944.723968608", tilt = "42.37613018389006" }));
                //kml.Document.Add(new Placemark(piv.plantName + "-1", desc, "#globeIcon1", "1", new Placemark.KMLPoint(piv.latitude, piv.Longitude, "1", "relativeToGround"), new Placemark.LookAt() { altitude = "0", heading = "137.6356988109601", latitude = "-152.6659616588421", longitude = "-152.6659616588421", range = "334944.723968608", tilt = "42.37613018389006" }));
                //kml.Document.Add(new Placemark(piv.plantName + "-2", desc, "#globeIcon2", "0", new Placemark.KMLPoint(piv.latitude, piv.Longitude, "1", "relativeToGround"), new Placemark.LookAt() { altitude = "0", heading = "137.6356988109601", latitude = "-152.6659616588421", longitude = "-152.6659616588421", range = "334944.723968608", tilt = "42.37613018389006" }));
                groundoverlaies.Add(new GroundOverlay
                {
                    name = piv.plantName + "overlay",
                    icon = config.domain + "/demoimg/3x.png",
                    visibility = "0",
                    LatLonBox = new GroundOverlay.LatLonBx { east = piv.Longitude - 1.5, rotation = 160, north = piv.latitude - 1.5, south = piv.latitude + 1.5, west = piv.Longitude + 1.5 },
                    LookAt = new GroundOverlay.Look
                    {
                        altitude = "1",
                        heading = "124",
                        latitude = "1",
                        longitude = "1",
                        range = "",
                        tilt = ""
                    }
                });

                groundoverlaies.Add(new GroundOverlay
                {
                    name = piv.plantName + "overlay-1",
                    icon = config.domain + "/demoimg/3x-1.png",
                    visibility = "0",
                    LatLonBox = new GroundOverlay.LatLonBx { east = piv.Longitude - 1.5, rotation = 160, north = piv.latitude - 1.5, south = piv.latitude + 1.5, west = piv.Longitude + 1.5 },
                    LookAt = new GroundOverlay.Look
                    {
                        altitude = "1",
                        heading = "124",
                        latitude = "1",
                        longitude = "1",
                        range = "",
                        tilt = ""
                    }
                });
            }
            kml.SaveToFile("plant.kml", groundoverlaies, config.domain);
            //config.MainInterval = this.tboxMainPage.Text;
            //config.DetailInterval = this.tboxDetailPage.Text;
            XMLHelper.SerializerXML<ConfigPara>(System.Environment.CurrentDirectory + "\\config.xml", config);
            MessageBox.Show("参数保存成功", "系统提示", MessageBoxButton.OK);
        }

        /// <summary>
        /// 取得电站列表
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnGetPlants_Click(object sender, RoutedEventArgs e)
        {
            if (tbxUserName.Text == "")
            {
                MessageBox.Show("请输入用户名！");
                return;
            }

            if (tbxUserPwd.Text == "")
            {
                MessageBox.Show("请输入密码！");
                return;
            }

            if (tboxDomain.Text == "")
            {
                MessageBox.Show("请输入Bank网址！");
                return;
            }
            addPids = "|";
            string json = JsonUtil.loadJsonStr(string.Format(tboxDomain.Text + "/openapi/plantinfolist?username={0}&userpwd={1}", tbxUserName.Text, tbxUserPwd.Text), "en-us");
            if (json.StartsWith("error:"))
            {
                MessageBox.Show(json.Substring(json.IndexOf(":") + 1));
                return;
            }

            pvos = JsonUtil.Deserialize<List<PlantInfoVo>>(json);
            if (pvos == null || pvos.Count.Equals(0))
            {
                MessageBox.Show("当前用户下没有电站信息！");
                return;
            }
            foreach (var vo in pvos)
            {
                vo.tipInterval = config.TipsInterval;
                vo.height = config.height;
                vo.detailInterval = config.DetailInterval;
            }
            //foreach (UIElement ui in plantsList.Children)
            //    if (ui is Label)
            //        ui.Visibility = Visibility.Visible;
            //plantsList.Visibility = Visibility.Visible;
            pageIndex = 1;
            config.PlantsInfo = pvos;
            this.comPageList.Items.Clear();
            BuildControls(pvos);
        }

        /// <summary>
        /// 翻页
        /// </summary>
        /// <param name="recordCount"></param>
        public void ProcessPage(int recordCount)
        {
            lblCurPage.Visibility = System.Windows.Visibility.Visible;
            comPageList.Visibility = System.Windows.Visibility.Visible;
            lblSkip.Visibility = System.Windows.Visibility.Visible;
            lblMainPage.Visibility = System.Windows.Visibility.Hidden;
            lblNextPage.Visibility = System.Windows.Visibility.Hidden;
            lblPrePage.Visibility = System.Windows.Visibility.Hidden;
            Pager page = new Pager();
            page.PageSize = PAGESIZE;
            page.RecordCount = recordCount;
            page.PageIndex = pageIndex;
            if (!page.IsFirst)
                lblMainPage.Visibility = System.Windows.Visibility.Visible;
            if (page.IsNext)
                lblNextPage.Visibility = System.Windows.Visibility.Visible;
            if (page.IsPre)
                lblPrePage.Visibility = System.Windows.Visibility.Visible;
            lblCurPage.Content = string.Format("{0}/{1} 页", pageIndex, page.PageCount);

            if (comPageList.Items.Count == 0)
            {
                int i = 1;
                comPageList.Items.Clear();
                while (i++ <= page.PageCount)
                    comPageList.Items.Add(string.Format("第{0}页", i - 1));
                comPageList.SelectedIndex = 0;
            }
            comPageList.SelectedIndex = page.PageIndex - 1;
        }

        private string addPid(string pid)
        {
            pid = string.Format("{0}|", pid);
            if (addPids.Contains(pid) == false)
                return addPids += pid;
            return addPids;
        }
        private string removePid(string pid)
        {
            pid = string.Format("{0}|", pid);
            addPids = addPids.Replace(pid, "|").Replace("||", "|");
            return addPids;
        }


        private void BuildControls(IList<PlantInfoVo> plants)
        {
            ProcessPage(plants.Count);
            plantsList.Children.Clear();
            plants = plants.Skip((pageIndex - 1) * PAGESIZE).Take(PAGESIZE).ToList<PlantInfoVo>();
            int y = 0;
            var png = new BitmapImage(new Uri(@"Images/main/suc_sy02.png", UriKind.RelativeOrAbsolute));
            int lineHeight = 36;
            double n = 5;
            double nn = 1;
            double x = 0.5;
            foreach (PlantInfoVo piv in plants)
            {
                bool check = config.TipsPlantsInfo.Count(m => m.plantId.Equals(piv.plantId)) > 0;
                //创建电站列表 点站名   精度 纬度  高度
                CheckBox cbox = new CheckBox();
                cbox.Width = 20;
                cbox.IsChecked = check;
                if (cbox.IsChecked.Value)
                    this.addPid(piv.plantId);
                cbox.Name = string.Format("pid_{0}", piv.plantId);
                cbox.Click += new RoutedEventHandler(cbox_Click);

                Canvas.SetLeft(cbox, 15);
                Canvas.SetTop(cbox, y * lineHeight + (n + y * x));
                plantsList.Children.Add(cbox);

                Label lbl = new Label();
                lbl.Name = string.Format("pname_{0}", piv.plantId);
                lbl.Width = 180;
                lbl.FontSize = 12;
                lbl.ToolTip = piv.plantName;
                lbl.Content = piv.plantName;
                Canvas.SetLeft(lbl, 50);
                Canvas.SetTop(lbl, (y * lineHeight + y * x));
                plantsList.Children.Add(lbl);

                //精度 
                TextBox tboxlong = new TextBox();
                tboxlong.Name = string.Format("tboxlong_{0}", piv.plantId);
                tboxlong.Text = piv.Longitude.ToString("0.000000000000");
                tboxlong.Width = 110;
                tboxlong.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);
                tboxlong.FontSize = 12;

                tboxlong.BorderThickness = new Thickness();
                tboxlong.Background = new ImageBrush(png);
                plantsList.Children.Add(tboxlong);

                Canvas.SetLeft(tboxlong, 235);
                Canvas.SetTop(tboxlong, y * lineHeight + (n + y * x));


                //纬度
                TextBox tboxlat = new TextBox();
                tboxlat.Name = string.Format("tboxlat_{0}", piv.plantId);
                tboxlat.Text = piv.latitude.ToString("0.000000000000");
                tboxlat.Width = 110;
                tboxlat.FontSize = 12;
                tboxlat.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);


                tboxlat.BorderThickness = new Thickness();
                tboxlat.Background = new ImageBrush(png);
                plantsList.Children.Add(tboxlat);
                Canvas.SetLeft(tboxlat, 360);
                Canvas.SetTop(tboxlat, y * lineHeight + (n + y * x));

                //高度
                TextBox tboxhei = new TextBox();
                tboxhei.Name = string.Format("tboxhei_{0}", piv.plantId);
                if (string.IsNullOrEmpty(piv.height))
                    tboxhei.Text = config.height;
                else
                    tboxhei.Text = piv.height;
                piv.height = tboxhei.Text;
                tboxhei.Width = 80;
                tboxhei.FontSize = 12;
                tboxhei.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);

                tboxhei.BorderThickness = new Thickness();
                tboxhei.Background = new ImageBrush(png);
                plantsList.Children.Add(tboxhei);
                Canvas.SetLeft(tboxhei, 480);
                Canvas.SetTop(tboxhei, y * lineHeight + (n + y * x));
                Label l = new Label();
                l.Content = "km";
                plantsList.Children.Add(l);
                Canvas.SetLeft(l, 560);
                Canvas.SetTop(l, y * lineHeight + (nn + y * x));

                //设计功率
                TextBox tboxdesignpower = new TextBox();
                tboxdesignpower.Name = string.Format("tboxdesignpower_{0}", piv.plantId);
                tboxdesignpower.Text = piv.design_power;
                tboxdesignpower.Width = 80;
                tboxdesignpower.FontSize = 12;
                tboxdesignpower.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);

                tboxdesignpower.BorderThickness = new Thickness();
                tboxdesignpower.Background = new ImageBrush(png);
                plantsList.Children.Add(tboxdesignpower);
                Canvas.SetLeft(tboxdesignpower, 605);
                Canvas.SetTop(tboxdesignpower, y * lineHeight + (n + y * x));
                l = new Label();
                l.Content = "kW";
                plantsList.Children.Add(l);
                Canvas.SetLeft(l, 684);
                Canvas.SetTop(l, y * lineHeight + (nn + y * x));
                //气泡显示时长
                TextBox tboxtiptime = new TextBox();
                tboxtiptime.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);

                tboxtiptime.Name = string.Format("tboxtiptime_{0}", piv.plantId);
                if (string.IsNullOrEmpty(piv.tipInterval))
                    tboxtiptime.Text = config.TipsInterval;
                else
                    tboxtiptime.Text = piv.tipInterval;
                tboxtiptime.FontSize = 12;
                piv.tipInterval = tboxtiptime.Text;
                tboxtiptime.Width = 80;
                tboxtiptime.BorderThickness = new Thickness();
                tboxtiptime.Background = new ImageBrush(png);
                tboxtiptime.HorizontalAlignment = HorizontalAlignment.Center;
                plantsList.Children.Add(tboxtiptime);
                Canvas.SetLeft(tboxtiptime, 735);
                Canvas.SetTop(tboxtiptime, y * lineHeight + (n + y * x));

                l = new Label();
                l.Content = "s";
                plantsList.Children.Add(l);
                Canvas.SetLeft(l, 813);
                Canvas.SetTop(l, y * lineHeight + (nn + y * x));

                //详细子页面时长
                TextBox tboxdetailtime = new TextBox();
                tboxdetailtime.Name = string.Format("tboxdetailtime_{0}", piv.plantId);
                if (string.IsNullOrEmpty(piv.detailInterval))
                    tboxdetailtime.Text = config.DetailInterval;
                else
                    tboxdetailtime.Text = piv.detailInterval;
                tboxdetailtime.Width = 80;
                tboxdetailtime.BorderThickness = new Thickness();
                tboxdetailtime.Background = new ImageBrush(png);
                tboxdetailtime.FontSize = 12;
                tboxdetailtime.TextChanged += new TextChangedEventHandler(tboxlong_TextChanged);
                piv.detailInterval = tboxdetailtime.Text;
                plantsList.Children.Add(tboxdetailtime);
                Canvas.SetLeft(tboxdetailtime, 860);
                Canvas.SetTop(tboxdetailtime, y * lineHeight + (n + y * x));
                l = new Label();
                l.Content = "s";
                plantsList.Children.Add(l);
                Canvas.SetLeft(l, 938);
                Canvas.SetTop(l, y * lineHeight + (nn + y * x));

                y++;
            }
        }

        void tboxlong_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox tbox = sender as TextBox;
            string pid = tbox.Name;
            //MessageBox.Show(pid);
            pid = pid.Substring(pid.IndexOf('_') + 1);
            foreach (PlantInfoVo vo in config.PlantsInfo)
                if (vo.plantId.Equals(pid))
                {
                    string value = findTextBox(string.Format("tboxlong_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.Longitude = double.Parse(value);
                    value = findTextBox(string.Format("tboxlat_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.latitude = double.Parse(value);
                    value = findTextBox(string.Format("tboxhei_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.height = value;
                    value = findTextBox(string.Format("tboxdesignpower_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.design_power = value;
                    value = findTextBox(string.Format("tboxdetailtime_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.detailInterval = value;
                    value = findTextBox(string.Format("tboxtiptime_{0}", vo.plantId));
                    if (string.IsNullOrEmpty(value) == false)
                        vo.tipInterval = value;
                }
        }

        void cbox_Click(object sender, RoutedEventArgs e)
        {
            CheckBox box = sender as CheckBox;
            string pid = box.Name.Substring(4);
            if (box.IsChecked.Value)
                addPid(pid);
            else
                removePid(pid);
        }

        private void btnReStart_Click(object sender, RoutedEventArgs e)
        {
            isStoprun = true;
            //先kill
            SystemUtil.KillProcess("sungrow_touch");

            if (cc != null)
            {
                cc.clear();
                cc = null;
            }
            this.startDemo();
        }

        private void btnStart_Click(object sender, RoutedEventArgs e)
        {
            isStoprun = true;
            startDemo();
        }

        /// <summary>
        /// 开始演示程序
        /// </summary>
        private void startDemo()
        {
            ConfigPara cpara = ConfigManagerService.GetInstance().LoadConfig();
            if (cpara == null || cpara.PlantsInfo.Count == 0 || cpara.TipsPlantsInfo.Count == 0)
            {
                MessageBoxResult mbResult;
                mbResult = MessageBox.Show("您尚未进行任何运行参数配置吗", "系统提示", MessageBoxButton.YesNo);
                if (mbResult.Equals(MessageBoxResult.Yes) == true)
                {
                    return;
                }
            }

            //启动电站详情页面程序
            startDetailExe();

            //启动页面播放控制中心
            cc = new ControlCenter();
            this.WindowState = WindowState.Minimized;
            cc.control();
        }

        /// <summary>
        /// 启动详情程序
        /// </summary>
        private void startDetailExe()
        {
            string isDebug = System.Configuration.ConfigurationManager.AppSettings["isDebug"];
            if (isDebug != null && "true".Equals(isDebug))
            {
                return;
            }

            //非调试状态下才kill touch进程
            SystemUtil.KillProcess("sungrow_touch");
            //启动
            ProcessStartInfo info = new ProcessStartInfo();
            info.FileName = getDetailPath();// @"路径\exe的文件名";              
            info.Arguments = "";
            info.WindowStyle = ProcessWindowStyle.Minimized;
            Process pro = Process.Start(info);
        }

        /// <summary>
        /// 取得详情程序的目录，如果有配置文件则读取配置文件的，用于调试
        /// 否则从当前运行路径组装而来
        /// </summary>
        /// <returns></returns>
        private string getDetailPath()
        {
            string enverionmentPath = System.Environment.CurrentDirectory;

            return enverionmentPath + "\\sungrow_touch.exe";
        }

        private void imgPlant_MouseUp(object sender, MouseButtonEventArgs e)
        {
            imgPlant.Source = new BitmapImage(new Uri(@"Images/main/suc_tab01.png", UriKind.RelativeOrAbsolute));
            imgGrobal.Source = new BitmapImage(new Uri(@"Images/main/suc_tab04.png", UriKind.RelativeOrAbsolute));
            plantsList.Visibility = Visibility.Visible;
            contentContainer.Background = new ImageBrush(new BitmapImage(new Uri(@"Images/main/suc_bg.jpg", UriKind.RelativeOrAbsolute)));
            this.grolbaConfig.Visibility = System.Windows.Visibility.Hidden;
            BuildControls(config.PlantsInfo);
        }

        private void imgGrobal_MouseUp(object sender, MouseButtonEventArgs e)
        {
            contentContainer.Background = new ImageBrush(new BitmapImage(new Uri(@"Images/main/suc_bg01.jpg", UriKind.RelativeOrAbsolute)));
            imgPlant.Source = new BitmapImage(new Uri(@"Images/main/suc_tab02.png", UriKind.RelativeOrAbsolute));
            imgGrobal.Source = new BitmapImage(new Uri(@"Images/main/suc_tab03.png", UriKind.RelativeOrAbsolute));
            plantsList.Visibility = Visibility.Hidden;
            this.grolbaConfig.Visibility = System.Windows.Visibility.Visible;

            foreach (UIElement c in contentContainer.Children)
            {
                if (c is Label || c is ComboBox)
                    (c as UIElement).Visibility = System.Windows.Visibility.Hidden;
            }

        }

        private void lblNextPage_MouseUp(object sender, MouseButtonEventArgs e)
        {
            pageIndex++;
            BuildControls(config.PlantsInfo);

        }

        private void lblPrePage_MouseUp(object sender, MouseButtonEventArgs e)
        {
            pageIndex--;
            BuildControls(config.PlantsInfo);

        }

        private void lblMainPage_MouseUp(object sender, MouseButtonEventArgs e)
        {
            pageIndex = 1;
            BuildControls(config.PlantsInfo);

        }

        private void comPageList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comPageList.SelectedIndex == -1)
                return;
            pageIndex = comPageList.SelectedIndex + 1;
            BuildControls(config.PlantsInfo);
        }

        private void WelcomeWindow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.F4)//ctrl+s   
            {
                this.notifyIcon.Visible = false;
                //先kill
                SystemUtil.KillProcess("sungrow_touch");

                //先清理资源再推出程序
                if (cc != null) cc.clear();
                //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
                //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
                //geProcess.Kill();
                this.Close();

                Environment.Exit(0);
            }
        }

        private void WelcomeWindow_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void grolbaConfig_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxheight_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxtipsinterval_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxdetailinterval_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxmainpageinterval_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void incomeRate_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void cbxCurrencyType_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void cbxCounterType_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tboxDomain_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tboxSysname_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void displayItems_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void displayPages_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void contentContainer_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxUserName_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void tbxUserPwd_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void btnGetPlants_MouseDown(object sender, MouseButtonEventArgs e)
        {
            isStoprun = true;
        }

        private void btnLogoConfirm_Click(object sender, RoutedEventArgs e)
        {
            SaveImage("logo", tbxLogoPath);
        }
        /// <summary>
        /// 尽支持png格式，jpg保存后会变形
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="tboxPath"></param>
        private void SaveImage(string fileName, TextBox tboxPath)
        {
            System.Windows.Forms.OpenFileDialog dialog = new System.Windows.Forms.OpenFileDialog();

            dialog.Multiselect = false;//不让多选。多选的话需要设置成FileNames
            dialog.Filter = "(图片类型 *.bmp;*.png;*.jpg;)|*.bmp;*.png;*.jpg;";
            dialog.ShowDialog();
            tboxPath.Text = dialog.FileName;//显示路径
            FileStream fs = new FileStream(tboxPath.Text.Trim(), FileMode.Open, FileAccess.Read);
            Bitmap bitmap = new Bitmap(fs);
            ImageFormat format;
            string formatStr = dialog.FileName.Substring(dialog.FileName.LastIndexOf('.') + 1);
            switch (formatStr.ToLower())
            {
                case "jpg":
                    format = ImageFormat.Jpeg;
                    break;
                case "png":
                    format = ImageFormat.Png;
                    break;
                case "bmp":
                    format = ImageFormat.Bmp;
                    break;
                default:
                    format = ImageFormat.Jpeg;
                    break;
            }
            //先删除原来的
            string ofile =string.Format("{0}/images/{1}.jpg", System.Environment.CurrentDirectory, fileName);
            if (File.Exists(ofile)) {
                File.Delete(ofile);
            }
            bitmap.Save(ofile, format);
        }

        private void btnInsideLogo_Click(object sender, RoutedEventArgs e)
        {
            SaveImage("insidelogo", tbxInsideLogoPath);
        }

        //[StructLayout(LayoutKind.Sequential)]
        //public class KeyBoardHookStruct //托管的结构体 用来记录Wparam传来的值
        //{
        //    public int vkCode;
        //    public int scanCode;
        //    public int flags;
        //    public int time;
        //    public int dwExtraInfo;
        //}

        //private delegate IntPtr CALLBACKHookProcHandle(int nCodeD, IntPtr wParamD, IntPtr lParam);

        //IntPtr hookID;//安装钩子后的这个钩子的句柄

        //[DllImport("kernel32.dll")]
        //private static extern IntPtr GetModuleHandle(string name);

        //[DllImport("kernel32.dll")]
        //static extern int GetCurrentThreadId();

        //[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        //private static extern IntPtr SetWindowsHookEx(
        //    int hookId, //用于调用钩子的类型 这里是键盘钩子
        //    CALLBACKHookProcHandle hookCallBack, //用于调用钩子的回调函数
        //    IntPtr currentThreadId, //用于安装钩子的当前进程的编号
        //    int hookState //安装那种类型的钩子0 为全局钩子的代码号
        //    );

        //[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        //private static extern IntPtr CallNextHookEx(
        //    IntPtr hookHandle, //钩子的句柄
        //    int ncode, //由钩子的回调函数传入的一个根据具体钩子类型的值
        //    IntPtr wParam, //这个消息的附加信息
        //    IntPtr lParam
        //    );

        //[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        //private static extern bool UnhookWindowsHookEx(IntPtr hookId);//用于卸载钩子的句柄

        //private void StartHook()
        //{
        //    const int WH_KEYBOARD = 13;//这是键盘钩子
        //    CALLBACKHookProcHandle callBackHandle = new CALLBACKHookProcHandle(this.CALLBACKHookProc);
        //    this.hookID = SetWindowsHookEx(WH_KEYBOARD, callBackHandle, GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName), 0);
        //}


        //private IntPtr CALLBACKHookProc(int nCode, IntPtr wParam, IntPtr lParam)
        //{
        //    if (nCode >= 0)//有按键按下 
        //    {
        //        KeyBoardHookStruct k = (KeyBoardHookStruct)Marshal. PtrToStructure(lParam, typeof(KeyBoardHookStruct));//将非托管的结构体转换为托管的结构体
        //        if (k.vkCode == (int)System.Windows.Forms.Keys.CapsLock)//设置你要屏蔽的按键（这里屏蔽的是大小写切换键）
        //        {
        //            return (IntPtr)1;//表示这个消息已被处理，不会在发送到其他应用程序的消息队列中去
        //        }

        //    }

        //    return CallNextHookEx(hookID, nCode, wParam, lParam);//将这个消息 放到钩子链中的其他钩子中

        //}
        //private void StopHook()
        //{
        //    UnhookWindowsHookEx(hookID);
        //}

    }
}
