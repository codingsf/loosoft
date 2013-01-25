using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Shapes;
using EARTHLib;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Threading;
using System.Windows.Interop;
using System.Windows.Forms;
using System.Windows.Media.Imaging;
using System.Net.Sockets;
using System.Text;
using SharpPlatform.GeDemo;
using System.Net;
using System.Windows.Threading;
using sungrow_demo.Service;
using sungrow_demo.Service.vo;

namespace sungrow_demo
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class GoogleEarth : Window
    {
        #region COM API定义
        private static readonly IntPtr HWND_BOTTOM = new IntPtr(1);
        private static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);
        private static readonly IntPtr HWND_TOP = new IntPtr(0);
        private static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
        //private static readonly UInt32 SWP_NOSIZE = 1;
        //private static readonly UInt32 SWP_HIDEWINDOW = 128;
        private static readonly Int32 WM_QUIT = 0x0012;
        public static readonly UInt32 SWP_FRAMECHANGED = 32;
        //private static readonly Int32 WM_HIDE = 0x0;

        public static readonly int WM_COMMAND = 0x0112;
        public static readonly int WM_QT_PAINT = 0xC2DC;
        public static readonly int WM_PAINT = 0x000F;
        public static readonly int WM_SIZE = 0x0005;

        bool isGeStarted = false;
        private IntPtr _GEHrender;
        private IntPtr _GEParentHrender;
        //private IntPtr _GEMainHandler;
        private IntPtr GEHWnd = (IntPtr)5;
        public IApplicationGE GeApp;
        public System.Windows.Forms.Panel panel_g;
        public bool isStopFlash = false;
        public bool isStopHotFlash = false;
         /// <summary>
        /// 呈现视图的控件
        /// </summary>
        System.Windows.Forms.Control control = null;
        //private TmWindow tmWin;

        /// <summary>
        /// 呈现区域的矩形
        /// </summary>
        private RECT clientRect;

        /// <summary>
        /// 鼠标钩子
        /// </summary>
        private HookAPI.MouseHook mouseHook;

        /// <summary>
        /// 获取呈现视图的控件
        /// </summary>
        public System.Windows.Forms.Control Control
        {
            get
            {
                return control;
            }
        }
        #endregion


        public GoogleEarth()
        {
            this.MaxHeight = 780;
            this.MaxWidth = 1380;
            this.Height = 780;
            this.Height = 1380;
            this.Left = -5.7;
            this.Top = -6;

            InitializeComponent();

            panel_g = new GERenderPanel();
            panel_g.Location = new System.Drawing.Point(0, 0);
            panel_g.Name = "panel1";
            panel_g.TabIndex = 0;
            panel_g.BorderStyle = BorderStyle.None;

            // Assign the MaskedTextBox control as the host control's child.
            System.Windows.Forms.RichTextBox rtb = new System.Windows.Forms.RichTextBox();
            rtb.Text = "dsfdsfd";
            panel_g.Top = 0;
            
            host.Child = panel_g;
            panel_g.SizeChanged += new EventHandler(p_SizeChanged);
            Canvas.SetZIndex(host, 1);
            this.control = panel_g;
            try
            {
                this.LoadGE();
            }catch(Exception ee)
            {
                LogUtil.error("LoadGE error:" + ee.StackTrace);
            }            
            this.setHook();
            try
            {
                loadKml();
            }
            catch (Exception ee)
            {
                LogUtil.error("loadKml error:" + ee.StackTrace);
            }   
        }

        /// <summary>
        /// 从局部飞出来，默认飞到合肥
        /// </summary>
        public void flyEarth(double jindu, double weidu, double range, double tmpSpeed)
        {
            double tmpalt, tmptilt, tmpAzimuth;
            //tmplat = 31.2;     //焦点纬度  
            //tmplng = 121.4;   //焦点经度  
            tmpalt = 0;        //焦点高度  
            //tmprange = 9800000;   //视场范围  
            tmptilt = 0;     //镜头倾角  
            tmpAzimuth = 25;   //镜头方位角  
            //tmpSpeed = 0.5;     //相机移动速度
            GeApp.SetCameraParams(weidu, jindu, tmpalt, AltitudeModeGE.RelativeToGroundAltitudeGE, range, tmptilt, tmpAzimuth, tmpSpeed);
        }

        public void loadKml() {
            string kml = System.Environment.CurrentDirectory + "\\plant.kml";
            GeApp.OpenKmlFile(kml, 1);
        }

        /// <summary>
        /// 显示地标气泡
        /// </summary>
        /// <param name="markName"></param>
        public void showFeature(string markName) {
            FeatureGE featureGE = GeApp.GetFeatureByName(markName);
            
            if (featureGE != null)
            {
                try
                {
                    GeApp.ShowDescriptionBalloon(featureGE);
                }
                catch (Exception ee) {
                    Console.WriteLine(ee.StackTrace);
                }
            }
        }

        /// <summary>
        /// 闪烁flash
        /// </summary>
        /// <param name="markName"></param>
        public void flashPlant(string markName)
        {
            DispatcherTimer dtn = new DispatcherTimer();
            dtn.Interval = TimeSpan.FromMilliseconds(1000);
            dtn.Tick += new EventHandler(delegate(object sender, EventArgs e)
            {
                if (isStopHotFlash)
                {
                    dtn.Stop();
                    return;
                }

                FeatureGE featureGE_1 = GeApp.GetFeatureByName(markName + "-1");
                FeatureGE featureGE_2 = GeApp.GetFeatureByName(markName + "-2");
                if (featureGE_1 != null && featureGE_2 != null)
                {
                    try
                    {
                        if (featureGE_1.Visibility == 1)
                        {
                            featureGE_2.Visibility = 1;
                            //featureGE_2.Highlight();
                            featureGE_1.Visibility = 0;
                        }
                        else
                        {
                            featureGE_1.Visibility = 1;
                            //featureGE_1.Highlight();
                            featureGE_2.Visibility = 0;
                        }
                    }
                    catch (Exception ee)
                    {
                        LogUtil.debug("flashPlant error:" + ee.StackTrace);
                    }
                }

            });//调用函数
            dtn.Start();

        }
        /// <summary>
        /// 闪烁flash
        /// </summary>
        /// <param name="markName"></param>
        public void flashOverlay(string markName) {
            DispatcherTimer dtn = new DispatcherTimer();
            dtn.Interval = TimeSpan.FromMilliseconds(1000);
            dtn.Tick += new EventHandler(delegate(object sender, EventArgs e)
            {
                if (isStopFlash) {
                    dtn.Stop();
                    return; 
                }

                FeatureGE featureGE = GeApp.GetFeatureByName(markName);
                FeatureGE featureGE_1 = GeApp.GetFeatureByName(markName+"-1");
                if (featureGE != null && featureGE_1 != null)
                {
                    try
                    {
                        if (featureGE.Visibility == 0)
                        {
                            featureGE_1.Visibility = 0;
                            featureGE.Visibility = 1;
                        }
                        else {
                            featureGE_1.Visibility = 1;
                            featureGE.Visibility = 0;
                        }
                    }
                    catch (Exception ee)
                    {
                        LogUtil.debug("flashOverlay error:" + ee.StackTrace);
                    }
                }

            });//调用函数
            dtn.Start();

        }

        /// <summary>
        /// 显示图层
        /// </summary>
        /// <param name="overLayName">图层名称</param>
        public void showOverlay(string overLayName)
        {
            FeatureGE featureGE = GeApp.GetFeatureByName(overLayName);

            if (featureGE != null)
            {
                try
                {
                    featureGE.Visibility = 1;
                }
                catch (Exception ee)
                {
                    Console.WriteLine(ee.StackTrace);
                }
            }
        }

        /// <summary>
        /// 显示图层
        /// </summary>
        /// <param name="overLayName">图层名称</param>
        public void hiddenOverlay(string overLayName)
        {
            FeatureGE featureGE = GeApp.GetFeatureByName(overLayName);

            if (featureGE != null)
            {
                try
                {
                    featureGE.Visibility = 0;
                }
                catch (Exception ee)
                {
                    LogUtil.debug("hiddenOverlay error:" + ee.StackTrace);
                }
            }
        }
   
        /// <summary>
        /// 显示地标气泡
        /// </summary>
        /// <param name="markName"></param>
        public void hiddenAllFeature()
        {
            GeApp.HideDescriptionBalloons();
        }

        /// <summary>
        /// 控件更改大小后，GoogleEarth视图大小也随着改变
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void p_SizeChanged(object sender, EventArgs e)
        {
            ResizeGoogleControl();
        }

        /// <summary>
        /// 只用来判断是否有人为介入
        /// </summary>
        private void setHook()
        {
            //设置鼠标钩子
            mouseHook = new HookAPI.MouseHook();
            mouseHook.MouseClick += new System.Windows.Forms.MouseEventHandler(delelate_MouseClick);
            long tid = 0;
            mouseHook.StartHook(HookAPI.HookType.WH_MOUSE_LL, tid);
        }

        //private void image_ManipulationStarting(object sender, ManipulationStartingEventArgs e)
        //{
        //    e.ManipulationContainer = touchPad;
        //    e.Mode = ManipulationModes.All;
        //}

        //private void image_ManipulationDelta(object sender, ManipulationDeltaEventArgs e)
        //{
        //    FrameworkElement element = (FrameworkElement)e.Source;
        //    element.Opacity = 0.5;

        //    Matrix matrix = ((MatrixTransform)element.RenderTransform).Matrix;

        //    var deltaManipulation = e.DeltaManipulation;

        //    Point center = new Point(element.ActualWidth / 2, element.ActualHeight / 2);
        //    center = matrix.Transform(center);

        //    matrix.ScaleAt(deltaManipulation.Scale.X, deltaManipulation.Scale.Y, center.X, center.Y);

        //    matrix.RotateAt(e.DeltaManipulation.Rotation, center.X, center.Y);

        //    matrix.Translate(e.DeltaManipulation.Translation.X, e.DeltaManipulation.Translation.Y);

        //    ((MatrixTransform)element.RenderTransform).Matrix = matrix;
        //}

        ////private void image_ManipulationCompleted(object sender, ManipulationCompletedEventArgs e)
        ////{
        ////    FrameworkElement element = (FrameworkElement)e.Source;
        ////    element.Opacity = 1;
        ////}

        ///// <summary>
        ///// 按钮手势开始
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        ////private void button_ManipulationStarting(object sender, ManipulationStartingEventArgs e)
        ////{
        ////    e.ManipulationContainer = touchPad;
        ////    e.Mode = ManipulationModes.Scale;
        ////}

        /// <summary>
        /// 按钮手势操作
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //private void button_ManipulationDelta(object sender, ManipulationDeltaEventArgs e)
        //{
        //    FrameworkElement element = (FrameworkElement)e.Source;
        //    element.Opacity = 0.5;

        //    Matrix matrix = ((MatrixTransform)element.RenderTransform).Matrix;

        //    var deltaManipulation = e.DeltaManipulation;

        //    Point center = new Point(element.ActualWidth / 2, element.ActualHeight / 2);
        //    center = matrix.Transform(center);

        //    matrix.ScaleAt(deltaManipulation.Scale.X, deltaManipulation.Scale.Y, center.X, center.Y);

        //    //matrix.RotateAt(e.DeltaManipulation.Rotation, center.X, center.Y);

        //    //matrix.Translate(e.DeltaManipulation.Translation.X, e.DeltaManipulation.Translation.Y);

        //    // ((MatrixTransform)element.RenderTransform).Matrix = matrix;
        //    Console.WriteLine("scrae" + deltaManipulation.Scale.X + "-" + deltaManipulation.Scale.Y);
        //}
        /// <summary>
        /// 按钮手势操作结束
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //private void button_ManipulationCompleted(object sender, ManipulationCompletedEventArgs e)
        //{
        //    FrameworkElement element = (FrameworkElement)e.Source;
        //    element.Opacity = 1;
        //}
        /// <summary>
        /// 图片上面
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        //private void Image_TouchMove(object sender, TouchEventArgs e)
        //{
        //    FrameworkElement element = (FrameworkElement)e.Source;
        //    Matrix matrix = ((MatrixTransform)element.RenderTransform).Matrix;

        //    TouchPoint touchPoint = e.GetTouchPoint(touchPad);

        //    Point center = new Point(element.ActualWidth / 2, element.ActualHeight / 2);
        //    center = matrix.Transform(center);

        //    //matrix.ScaleAt(deltaManipulation.Scale.X, deltaManipulation.Scale.Y, center.X, center.Y);
        //    Console.WriteLine("touchpoint.Bounds.Left" + touchPoint.Bounds.Left);
        //}

        #region  GE地图
        /// <summary>
        /// 加载GE地图
        /// </summary>
        /// <summary>
        /// 加载Google Earth
        /// </summary>
        private void LoadGE()
        {
            if (isGeStarted)
            {
                return;
            }
            try
            {
                GeApp = (ApplicationGEClass)Activator.CreateInstance(Type.GetTypeFromProgID("GoogleEarth.Application"));
                isGeStarted = true;
            }
            catch
            {
                GeApp = new ApplicationGEClass();
                // 30%;
                ///progress.WorkDown = 30;
                isGeStarted = true;
            }

            GEHWnd = (IntPtr)GeApp.GetMainHwnd();

            //隐藏主窗口
            //NativeMethods.SetWindowPos(GEHWnd, NativeMethods.HWND_BOTTOM, 0, 0, 0, 0, NativeMethods.SWP_HIDEWINDOW);

            NativeMethods.ShowWindowAsync((int)GEHWnd, 0);
            // 40%;
            //progress.WorkDown = 40;

            _GEHrender = (IntPtr)GeApp.GetRenderHwnd();
            _GEParentHrender = (IntPtr)NativeMethods.GetParent(_GEHrender);

            NativeMethods.SetParent(_GEHrender, this.Control.Handle);
            // 50%;
            //progress.WorkDown = 50;

            ResizeGoogleControl();
        }

        /// &lt;summary&gt;
        /// 释放GE句柄
        /// &lt;/summary&gt;
        public void RealseGEHandler()
        {
            try
            {
                if (this.GeApp != null)
                {
                    //将GE地图控件的句柄还原到GE主窗体上去
                    NativeMethods.SetParent(this._GEHrender, this._GEParentHrender);
                    //关闭GE主程序
                    NativeMethods.PostMessage((IntPtr)this.GeApp.GetMainHwnd(), WM_QUIT, 0, 0);
                }
            }
            finally
            {
                //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
                //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
                //geProcess.Kill();
            }
        }

        /// &lt;summary&gt;
        /// 使GE控件的大小和父窗体的大小保持一致
        /// &lt;/summary&gt;
        /// <summary>
        /// 重新改变GoogleEarth视图的大小
        /// </summary>
        public void ResizeGoogleControl()
        {
            NativeMethods.SendMessage(GEHWnd, (uint)NativeMethods.WM_COMMAND, NativeMethods.WM_PAINT, 0);
            NativeMethods.PostMessage(GEHWnd, NativeMethods.WM_QT_PAINT, 0, 0);

            RECT mainRect = new RECT();
            NativeMethods.GetWindowRect(GEHWnd, out mainRect);
            clientRect = new RECT();
            NativeMethods.GetClientRect(_GEHrender, out clientRect);

            //long offsetW = (mainRect.Right - mainRect.Left) - (clientRect.Right - clientRect.Left);
            //long offsetH = (mainRect.Bottom - mainRect.Top) - (clientRect.Bottom - clientRect.Top);

            int offsetW = mainRect.Width - clientRect.Width;
            int offsetH = mainRect.Height - clientRect.Height;

            int newWidth = this.Control.Width;// +(int)offsetW;
            int newHeight = this.Control.Height;// +(int)offsetH;

            NativeMethods.SetWindowPos(GEHWnd, NativeMethods.HWND_TOP,
                0, 0, newWidth, newHeight, 
                NativeMethods.SWP_FRAMECHANGED);

            NativeMethods.SendMessage(GEHWnd, (uint)NativeMethods.WM_COMMAND, NativeMethods.WM_SIZE, 0);
            NativeMethods.MoveWindow(this._GEHrender, 0, 0, newWidth, newHeight, true);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // string kml = Application.p + "\\text.kml";
            //this.laod_KNL(kml);
        }
        private void laod_KNL(string kml)
        {
            GeApp.OpenKmlFile(kml, 1);
        }
        #endregion

        private void host_MouseDown(object sender, MouseButtonEventArgs e)
        {
            System.Windows.MessageBox.Show("dsfd");
        }

        /// <summary>
        /// 鼠标钩子。鼠标单击事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void delelate_MouseClick(object sender, System.Windows.Forms.MouseEventArgs e)
        {
            IntPtr hWnd = NativeMethods.WindowFromPoint(e.Location);
            if (hWnd == this._GEHrender)
            {
                System.Drawing.Point point = this.Control.PointToClient(e.Location);
                // 如果鼠标击点位置在控件内部，则说明鼠标点击了GoogleEarth视图
                if (this.Control.ClientRectangle.Contains(point))
                {
                    Console.WriteLine("点击了GoogleEarth...");

                    DoublePoint dp = ((GERenderPanel)Control).DetermineScreenCoordinates(point.X, point.Y);

                    ParameterizedThreadStart pts = new ParameterizedThreadStart(ShowMouseClickPoint);

                    Thread thread = new Thread(pts);
                    thread.Start(dp);

                }
            }
        }

        /// <summary>
        /// 如果有鼠标点击事件，则置中断标识
        /// </summary>
        /// <param name="obj"></param>
        protected void ShowMouseClickPoint(object obj)
        {
            ControlCenter.pauseTime = DateTime.Now;
            ControlCenter.isPause = true;
            DoublePoint dp = (DoublePoint)obj;
            PointOnTerrainGE pGe = GeApp.GetPointOnTerrainFromScreenCoords(dp.X, dp.Y);
            Console.WriteLine("鼠标点击了：Lnt=" + pGe.Longitude.ToString()
                + ";Lat=" + pGe.Latitude.ToString());

            ///displayDetailByclick(pGe);
        }

        private string getPlantByPoint(string j,string w ) {
            return "";
        }


        protected void ShowMouseDbClickPoint(object obj)
        {
            ////Thread.Sleep(20);
            //DoublePoint dp = (DoublePoint)obj;
            //PointOnTerrainGE pGe = GeApp.GetPointOnTerrainFromScreenCoords(dp.X, dp.Y);
            //Console.WriteLine("xx鼠标双击了：Lnt=" + pGe.Longitude.ToString()
            //    + ";Lat=" + pGe.Latitude.ToString());

            System.Windows.Forms.MessageBox.Show("我还是出来一下吧！省得你不知道你已经双击了鼠标！");
        }

        /// <summary>
        /// 鼠标钩子。鼠标滚动事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void mouseHook_MouseWheel(object sender, System.Windows.Forms.MouseEventArgs e)
        {
            //IntPtr hWnd = NativeMethods.WindowFromPoint(e.Location);
            //if (hWnd == this.GeRenderHWnd)
            //{
            //    Point point = this.Control.PointToClient(e.Location);
            //    // 如果鼠标位置在控件内部，则说明鼠标在GoogleEarth视图范围内进行了滚动
            //    if (this.Control.ClientRectangle.Contains(point))
            //    {
            //        Console.WriteLine("鼠标滚动了！...");
            //        // 此处滚动方法不正确，只能放大，不能缩小。O(∩_∩)O~
            //        NativeMethods.PostMessage(GeRenderHWnd, (int)WM_MOUSE.WM_MOUSEWHEEL, 0, e.Delta > 120 ? -120 : 120);
            //    }
            //}
        }


        private void touchPad_MouseDown(object sender, MouseButtonEventArgs e)
        {
            System.Windows.MessageBox.Show("dsfd");
        }

        private void earthWindow_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {

            if (GeApp != null)
            {
                NativeMethods.PostMessage((IntPtr)GeApp.GetMainHwnd(), WM_QUIT, 0, 0);
            }

            Process[] localByNameApp = Process.GetProcessesByName("googleearth");
            foreach (Process process in localByNameApp)
            {
                if (!process.HasExited)
                    process.Kill();
            }
        }

        private void earthWindow_KeyDown(object sender, System.Windows.Input.KeyEventArgs e)
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
