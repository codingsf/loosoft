using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using SharpPlatform.GeDemo;
using System.Windows.Threading;
using System.Configuration;

namespace sungrow_touch
{
    public partial class MainForm : Form
    {
        //IntPtr curh;
        public MainForm()
        {
            InitializeComponent();
            string isDebug = ConfigurationManager.AppSettings["isDebug"];
            if (isDebug != null && isDebug.Equals("true"))
            {
                FileUtil.WriteFile(ConfigurationManager.AppSettings["demo_config_file"], "touchjb.txt", this.Handle.ToString());
            }
            else {
                FileUtil.WriteFile(Environment.CurrentDirectory, "touchjb.txt", this.Handle.ToString());
            }
        }

        private void MainForm_Load(object sender, EventArgs e)
        {

        }

        Detail_1 dd = null;
        public void showDetail(string plantId,bool isAuto)
        {
            if (dd != null)
            {
                dd.Close();
            }
            dd = new Detail_1(plantId, isAuto);
            //dd.ShowActivated = true;
            dd.loadData();
            //try
            //{
            //    dd.Show();
            //}
            //catch (Exception ee)
            //{
            //}
            changeSize();  
        }

        /// <summary>
        /// 简便窗体
        /// </summary>
        private void changeSize() {
            //延迟后面动作
            DispatcherTimer dtn = new DispatcherTimer();
            dtn.Interval = TimeSpan.FromMilliseconds(1);
            dtn.Tick += new EventHandler(delegate(object sender1, EventArgs e1)
            {
                dtn.Stop();
                dd.changesize();
            });//调用函数
            dtn.Start();
        }

        public void closeDetail()
        {
            if (dd != null)
            {
                dd.Close();
            }
        }


        /// <summary>
        /// 接收消息
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
                    if (mystr.lpData.StartsWith("open"))
                    {
                        showDetail(mystr.lpData.Substring(mystr.lpData.IndexOf("-")+1),true);
                    }
                    else if (mystr.lpData.StartsWith("manualopen"))
                    {
                        showDetail(mystr.lpData.Substring(mystr.lpData.IndexOf("-") + 1), false);
                    }
                    else
                        if (mystr.lpData.StartsWith("close"))
                        {
                            closeDetail();
                        }
                        else
                        {
                            Detail_1.WINDOW_HANDLER = int.Parse(mystr.lpData);
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
