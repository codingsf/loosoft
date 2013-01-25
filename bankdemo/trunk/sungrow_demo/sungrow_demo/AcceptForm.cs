using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using SharpPlatform.GeDemo;
using System.Threading;
using sungrow_demo.Service;

namespace sungrow_demo
{
    public partial class AcceptForm : Form
    {
        private Thread m_thread;
        HttpServer httpServer;
        ControlCenter cc;
        public AcceptForm(ControlCenter cc)
        {
            this.cc = cc;
            InitializeComponent();
            FileUtil.WriteFile(Environment.CurrentDirectory, "demojb.txt", this.Handle.ToString());
            LogUtil.debug("write demo port:" + this.Handle.ToString());
            //MessageBox.Show("demo WINDOW_HANDLER：" + this.Handle.ToString());
            httpServer = new HttpServer();
            m_thread = new Thread(new ThreadStart(httpServer.start));
            m_thread.Name = "Http Thread";
            m_thread.Start();
        }
        public AcceptForm()
        { }
        /// <summary>
        /// 清理线程
        /// </summary>
        public void clear() {
            LogUtil.debug("clare httpserver");
            httpServer.stop();
            httpServer = null;
        }

        private void AcceptForm_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// 发送到其他窗体的命令
        /// </summary>
        /// <param name="message"></param>
        public static void sendCmdMessage(string message) {
            try
            {
                string jb = FileUtil.ReadFile(Environment.CurrentDirectory + "\\touchjb.txt");
                int WINDOW_HANDLER = int.Parse(jb);
                sendCmdMessage(message, WINDOW_HANDLER);
            }catch(Exception filee){
                LogUtil.error("read touchjb.txt file error " + ":" + filee.Message);
                //如果出错那么继续下一个
                ControlCenter.isColseDetail = true;
            }
        }

        /// <summary>
        /// 发送到其他窗体的命令
        /// </summary>
        /// <param name="message"></param>
        public static void sendCmdMessage(string message,int jb)
        {
            if (jb > 0)
            {
                byte[] sarr = System.Text.Encoding.Default.GetBytes(message);
                int len = sarr.Length;
                COPYDATASTRUCT cds;
                cds.dwData = (IntPtr)100;
                cds.lpData = message;
                cds.cbData = len + 1;
                NativeMethods.SendMessage(jb, NativeMethods.WM_COPYDATA, 0, ref   cds);
                LogUtil.debug("sendCmdMessage to "+jb+":" + message);
            }
        }

        /// <summary>
        /// 接收来自详细页面的消息
        /// </summary>
        /// <param name="m"></param>
        protected override void DefWndProc(ref   System.Windows.Forms.Message m)
        {
            switch (m.Msg)
            {
                case NativeMethods.WM_COPYDATA:
                    COPYDATASTRUCT mystr = new COPYDATASTRUCT();
                    Type mytype = mystr.GetType();
                    mystr = (COPYDATASTRUCT)m.GetLParam(mytype);
                    if (mystr.lpData.StartsWith("isdetailclick"))
                    {
                        LogUtil.debug("isdetailclick:" + mystr.lpData);
                        ControlCenter.pauseTime = DateTime.Now;
                        ControlCenter.isPause = true;
                    }
                    else if (mystr.lpData.StartsWith("startindex"))//回首页
                    {
                        LogUtil.debug("startindex:" + mystr.lpData);
                        cc.playIndex();
                    }
                    else if (mystr.lpData.StartsWith("nextdetail"))//播放下一个详情页面
                    {
                        LogUtil.debug("nextdetail:" + mystr.lpData);
                        ControlCenter.isColseDetail = true;
                    }
                    else if (mystr.lpData.StartsWith("exit"))//退出系统
                    {
                        //先kill
                        SystemUtil.KillProcess("sungrow_touch");

                        //先清理资源再退出程序
                        if (Main.cc != null) Main.cc.clear();
                        //为防本程序的进程不能成功退出而导致GE出现问题，强制杀掉本程序的进程
                        //System.Diagnostics.Process geProcess = System.Diagnostics.Process.GetCurrentProcess();
                        //geProcess.Kill();
                        this.Close();
                        LogUtil.debug("exit:" + mystr.lpData);
                        Environment.Exit(0);
                    }
                    
                    break;
                default:
                    base.DefWndProc(ref   m);
                    //MessageBox.Show("no");
                    break;
            }
        }
    }
}
