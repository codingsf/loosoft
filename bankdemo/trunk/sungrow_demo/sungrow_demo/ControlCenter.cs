using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Threading;
using System.Threading;
using EARTHLib;
using sungrow_demo.Service;
using sungrow_demo.Service.vo;

namespace sungrow_demo
{
    /// <summary>
    /// 页面播放控制器
    /// </summary>
    public class ControlCenter
    {
        public static DateTime pauseTime = DateTime.Now;//中断时间
        public static bool isPause = false;//是否中断标识

        string fly_range = System.Configuration.ConfigurationManager.AppSettings["fly_range"];
        string loadearthTime = System.Configuration.ConfigurationManager.AppSettings["loadearth.time"];
        string plantOrder = System.Configuration.ConfigurationManager.AppSettings["plant.order"];
        
        /// <summary>
        /// 页面播放时间记时
        /// </summary>
        private Dictionary<int, int> pageCountDic = new Dictionary<int, int>();
        private Dictionary<int, int> pagePlaytimeDic = new Dictionary<int, int>();
        public static MainWindow mainWindow;  //首页
        public static GoogleEarth googleEarth;//地球页面
        private AcceptForm af = null;

        private int PAGE_INDEX = 1; //首页
        private int PAGE_DETAIL = 2;//详细页面
        private List<PlantInfoVo> hotPlants;//播放热点电站
        private List<PlantInfoVo> allPlants;//所有电站
        private IDictionary<string, PlantInfoVo> plantmap = new Dictionary<string, PlantInfoVo>();
        private int turnBatchNum = 3;//每一批轮播数量
        private int turnIndex = 0;//轮播下标
        private int hotBatchNum = 2;//每一批轮播数量
        private int hotIndex = 0;//轮播下标
        public static bool isColseDetail = false;//关闭详情页面标识，用于自动播放模式

        private static ControlCenter cc = null;//控制中心单实例
        public ControlCenter(){
            try
            {
                pauseTime = DateTime.Now;
                isPause = false;//是否中断标识
                //初始化页面记时数组
                pageCountDic.Add(PAGE_INDEX, 0);
                pageCountDic.Add(PAGE_DETAIL, 0);
                //页面播放时间设置
                pagePlaytimeDic.Add(PAGE_INDEX, int.Parse(ConfigManagerService.GetInstance().LoadConfig().MainInterval));

                hotPlants = ConfigManagerService.GetInstance().LoadConfig().TipsPlantsInfo;
                allPlants = ConfigManagerService.GetInstance().LoadConfig().PlantsInfo;
                //add by qhb in 20120116 for 添加对电站按照精度排序
                hotPlants = orderPlants(hotPlants, plantOrder);
                allPlants = orderPlants(allPlants, plantOrder);
                foreach (PlantInfoVo plantInfoVo in allPlants)
                {
                    plantmap.Add(plantInfoVo.plantId, plantInfoVo);
                }
                loadAcceptForm(this);

                //初始化页面
                loadHiddenMain();
                loadHiddenEarth();
                //休眠20s 用于地球加载
                if (loadearthTime == null) loadearthTime = "20";
                Thread.Sleep(int.Parse(loadearthTime) * 1000); 
            }
            catch (Exception ee) {
                LogUtil.error("ControlCenter error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 按照精度排序电站
        /// <param name="inverterDevices"></param>
        /// <returns></returns>
        private List<PlantInfoVo> orderPlants(List<PlantInfoVo> plants, string plantOrder)
        {
            if(plantOrder==null)plantOrder="desc";

            List<PlantInfoVo> newPlants = new List<PlantInfoVo>();
            if (plants == null) return newPlants;
            IEnumerable<PlantInfoVo> sortDevices = null;
            if ("desc".Equals(plantOrder.ToLower().Trim()))
            {
                sortDevices = plants.OrderByDescending(model => model.Longitude);
            }
            else {
                sortDevices = plants.OrderBy(model => model.Longitude);
            }
            return sortDevices.ToList<PlantInfoVo>();
        }

        public static ControlCenter getInstance()
        {
            if (cc == null) {
                cc = new ControlCenter();
            }
            return cc;
        }

        private void loadAcceptForm(ControlCenter cc)
        {
            af = new AcceptForm(cc);
            af.Hide();
        }

        /// <summary>
        /// 按批次取得热点电站
        /// </summary>
        /// <returns></returns>
        private List<PlantInfoVo> getBatchHotPlants() {
            List<PlantInfoVo> news = new List<PlantInfoVo>();
            try
            {
                int startIndex = hotIndex;
                int endIndex = hotIndex + hotBatchNum;
                endIndex = endIndex > hotPlants.Count ? hotPlants.Count - 1 : endIndex - 1;

                hotIndex = endIndex + 1;
                if (endIndex == hotPlants.Count - 1) hotIndex = 0;
                for (int i = startIndex; i <= endIndex; i++)
                {
                    news.Add(hotPlants[i]);
                }
            }
            catch (Exception ee) {
                LogUtil.error("getBatchHotPlants error:" + ee.StackTrace);
            }
            return news;
        }

        /// <summary>
        /// 影藏加载首页
        /// </summary>
        private void loadHiddenMain()
        {
            mainWindow = new MainWindow();
            mainWindow.Hide();
        }

        /// <summary>
        /// 隐藏加载地球
        /// </summary>
        private void loadHiddenEarth()
        {
            googleEarth = new GoogleEarth();
            googleEarth.Hide();
        }

        /// <summary>
        /// 清理释放资源
        /// </summary>
        public void clear() {
            try
            {
                googleEarth.RealseGEHandler();
                googleEarth.Close();
                googleEarth = null;
                mainWindow.Close();
                mainWindow = null;
                af.clear();
                af.Close();
                af = null;
            }
            catch (Exception ee) {
                LogUtil.error("clear error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 播放首页
        /// </summary>
        public void playIndex() {
            try
            {
                //记时清零
                pageCountDic[PAGE_INDEX] = 0;
                //先关闭第三个弹出页面
                AcceptForm.sendCmdMessage("close detail");
                //显示要求的窗体
                mainWindow.Show();
                //隐藏地球页面显示
                googleEarth.Hide();
                //开始倒计时
                DispatcherTimer dt = new DispatcherTimer();
                dt.Interval = TimeSpan.FromSeconds(1);
                dt.Tick += new EventHandler(delegate(object sender, EventArgs e)
                {
                    LogUtil.debug("start play index");
                    //如果中断操作时间小于设置的值，则不处理自动播放动作
                    if (isPause && DateTime.Now.Subtract(pauseTime).TotalSeconds < 10)
                    {
                        LogUtil.debug("首页播放被中断，中断操作停止时间为：" + pauseTime);
                        hiddenAllOverlay();
                        return;
                    }
                    else
                    {
                        LogUtil.debug("中断失效，解析播放");
                        isPause = false;
                    }

                    //没人工终端则进行页面记时
                    pageCountDic[PAGE_INDEX] = pageCountDic[PAGE_INDEX] + 1;

                    //播放时间到则播放下一个页面
                    if (pageCountDic[PAGE_INDEX] >= pagePlaytimeDic[PAGE_INDEX])
                    {
                        LogUtil.debug("进入地球");
                        //进入地球
                        enterEarth();
                        //停止定时器
                        dt.Stop();
                    }

                });//调用函数
                dt.Start();
            }
            catch (Exception ee) {
                LogUtil.error("playIndex error:" + ee.StackTrace);
            }
        }

        private void enterEarth()
        {
            try
            {
                googleEarth.ResizeGoogleControl();
                //先出飞行效果
                googleEarth.flyEarth(1, 31.86, 51000000, 1);

                if (hotPlants.Count > 1)
                {
                    //先出飞行效果
                    DispatcherTimer dt = new DispatcherTimer();
                    dt.Interval = TimeSpan.FromSeconds(1);
                    dt.Tick += new EventHandler(delegate(object sender, EventArgs e)
                    {
                        LogUtil.debug("开始延时飞行");
                        dt.Stop();
                        timeoutFly();
                    });//调用函数
                    dt.Start();
                }
                else {
                    //播放一轮后开始单个播放
                    curPlantIndex = 0;
                    tmpHotPlants = getBatchHotPlants();
                    playEarth();
                }
            }
            catch (Exception ee) {
                LogUtil.error("enterEarth error:" + ee.StackTrace);
            }
        }

        private void timeoutFly(){
            try
            {
                double j = 10;
                double range = 49000000;
                googleEarth.flyEarth(j, 11.86, range, 0.2);
                DispatcherTimer dt = new DispatcherTimer();
                dt.Interval = TimeSpan.FromMilliseconds(100);
                dt.Tick += new EventHandler(delegate(object sender, EventArgs e)
                {
                    j += 10;
                    range -= 2000000;
                    googleEarth.flyEarth(j, 31.86, range, 0.2);
                    if (j > 117)
                    {
                        dt.Stop();
                        flashAllOverlay();
                        LogUtil.debug("开始轮播");
                        turnPlay();
                        //显示的窗体
                        googleEarth.Show();
                        //隐藏首页页面显示
                        mainWindow.Hide();
                    }

                });//调用函数
                dt.Start();
            }
            catch (Exception ee) {
                LogUtil.error("timeoutFly error:" + ee.StackTrace);
            }
        }

        /// <summary>
        ///  轮播电站
        /// </summary>
        private void turnPlay() {
            LogUtil.debug("start turn Play");
            try
            {
                double tmp_fly_range = 19800000;
                //显示所有图层
                displayAllOverlay();
                flashAllOverlay();
                PlantInfoVo plant;
                int i = 0;

                DispatcherTimer dt = new DispatcherTimer();
                dt.Interval = TimeSpan.FromSeconds(4);
                dt.Tick += new EventHandler(delegate(object sender, EventArgs e)
                {

                    LogUtil.debug("start timeout 轮播:");
                    if (isPause && DateTime.Now.Subtract(pauseTime).TotalSeconds < 10)
                    {
                        LogUtil.debug("轮播被中断,时间为：" + pauseTime);
                        hiddenAllOverlay();
                        return;
                    }
                    else
                    {
                        LogUtil.debug("中断失效");
                        isPause = false;
                    }
                    //先影藏所有气泡
                    googleEarth.hiddenAllFeature();
                    if (i == turnBatchNum || turnIndex == allPlants.Count)
                    {
                        LogUtil.debug("单个播放");
                        if (turnIndex == allPlants.Count)
                            turnIndex = 0;
                        dt.Stop();
                        //播放一轮后开始单个播放
                        curPlantIndex = 0;
                        tmpHotPlants = getBatchHotPlants();
                        playEarth();
                    }
                    else
                    {
                        LogUtil.debug("轮播" + turnIndex);
                        plant = allPlants[turnIndex];
                        //再飞到当前热点
                        googleEarth.flyEarth(plant.Longitude, plant.latitude, tmp_fly_range, 1);
                        //冒泡
                        //弹出气泡
                        googleEarth.showFeature(plant.plantName);
                        i++;
                        turnIndex++;
                    }

                });//调用函数
                dt.Start();
            }
            catch (Exception ee) {
                LogUtil.error("轮播 error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 播放地球页面
        /// 地球页面不记时播放，而是按照热点逐个播放
        /// </summary>
        IList<PlantInfoVo> tmpHotPlants;
        int curPlantIndex = 0;//当前热点下标
        private void playEarth() {
            try
            {
                //显示的窗体
                googleEarth.Show();
                //隐藏首页页面显示
                mainWindow.Hide();
                //googleEarth.Control.Width = (int)googleEarth.ActualWidth;
                //googleEarth.Control.Height = (int)googleEarth.ActualHeight;
                //googleEarth.host.Width = googleEarth.ActualWidth;
                //googleEarth.host.Height = googleEarth.ActualHeight;
                //googleEarth.hiddenAllFeature();
                //首先将地球有小转动到大

                //然后开始捉个热点播放
                //如果播放完了那么开始播放首页
                if (curPlantIndex >= tmpHotPlants.Count())
                {
                    //重置播放下标
                    curPlantIndex = 0;
                    //开始播放首页
                    playIndex();
                    //退出播放地球方法
                    return;
                }

                //播放当前热点
                //根据当前下标取得当前播放电站
                PlantInfoVo plant = tmpHotPlants[curPlantIndex];
                //先关闭详细
                AcceptForm.sendCmdMessage("close detail");//
                double h = 0;
                try
                {
                    h = double.Parse(plant.height);
                }
                catch (Exception e) {
                    Console.WriteLine(e.Message);
                    h = 19800000;
                }
                //先飞到合肥
                googleEarth.flyEarth(117.27, 31.86, h, 0.3);

                int yanchis = 0;
                //延迟后面动作
                DispatcherTimer dtn = new DispatcherTimer();
                dtn.Interval = TimeSpan.FromSeconds(1);
                dtn.Tick += new EventHandler(delegate(object sender, EventArgs e)
                {
                    //如果中断操作时间小于设置的值，则不处理自动播放动作
                    if (isPause && DateTime.Now.Subtract(pauseTime).TotalSeconds < 10)
                    {
                        LogUtil.debug("轮播详细页面 中断:" + pauseTime);
                        hiddenAllOverlay();
                        return;
                    }
                    else
                    {
                        isPause = false;
                    }
                    yanchis++;
                    if (yanchis == 1)
                    {
                        dtn.Stop();
                        yanchis = 0;
                        //影藏所有图层
                        hiddenAllOverlay();
                        //再飞到当前热点
                        googleEarth.flyEarth(plant.Longitude, plant.latitude, double.Parse(fly_range), 1);//3000000
                        //播放电站详细页面
                        playDetail(plant.plantId, plant.plantName);
                        LogUtil.debug("轮播详细页面:" + plant.plantId + plant.plantName);
                    }

                });//调用函数
                dtn.Start();

                //置下一个热点
                curPlantIndex++;
            }
            catch (Exception ee) {
                LogUtil.error("播放详细页面 error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 显示所有图层
        /// </summary>
        private void displayAllOverlay() {
            foreach (PlantInfoVo plant in allPlants)
            {
                googleEarth.showOverlay(plant.plantName + "overlay");
            }
        }

        /// <summary>
        /// 闪烁所有电站图层
        /// </summary>
        private void flashAllOverlay() {
            googleEarth.isStopFlash = false;
            foreach (PlantInfoVo plant in allPlants)
            {
                googleEarth.flashOverlay(plant.plantName + "overlay");
            }
        }

        /// <summary>
        /// 影藏所有图层
        /// </summary>
        private void hiddenAllOverlay()
        {
            googleEarth.isStopFlash = true;
            foreach (PlantInfoVo plant in allPlants)
            {
                googleEarth.hiddenOverlay(plant.plantName + "overlay");
                googleEarth.hiddenOverlay(plant.plantName + "overlay-1");
            }
        }

        /// <summary>
        /// 记时播放电站详细页面
        /// </summary>
        /// <param name="plantId"></param>
        private void playDetail(string plantId,string plantName) {
            try
            {
                googleEarth.isStopHotFlash = false;
                //googleEarth.flashPlant(plantName);
                isColseDetail = false;
                int tiptime = int.Parse(plantmap[plantId].tipInterval);
                //记时清零
                pageCountDic[PAGE_DETAIL] = 0;
                //弹出气泡
                googleEarth.showFeature(plantName);
                //开始倒计时
                DispatcherTimer dtd = new DispatcherTimer();
                dtd.Interval = TimeSpan.FromSeconds(1);
                dtd.Tick += new EventHandler(delegate(object sender, EventArgs e)
                {
                    //如果中断操作时间小于设置的值，则不处理自动播放动作
                    if (isPause && DateTime.Now.Subtract(pauseTime).TotalSeconds < 10)
                    {
                        hiddenAllOverlay();
                        return;
                    }
                    else
                    {
                        if (isPause) isColseDetail = true; ;
                        isPause = false;
                    }
                    //2秒后才弹出详细页面
                    if (pageCountDic[PAGE_DETAIL] == tiptime)
                    {
                        AcceptForm.sendCmdMessage("open-" + plantId);//打开详细页面
                        googleEarth.hiddenAllFeature();
                    }

                    //2秒后才弹出详细页面
                    //if (pageCountDic[PAGE_DETAIL] == 5)
                    //{
                    //googleEarth.hiddenAllFeature();
                    //}

                    pageCountDic[PAGE_DETAIL] = pageCountDic[PAGE_DETAIL] + 1;

                    //播放时间到则播放下一个热点.记时有误差，取消这种方式
                    //if (isColseDetail || pageCountDic[PAGE_DETAIL] >= pagePlaytimeDic[PAGE_DETAIL] + 5)

                    if (isColseDetail)
                    {
                        googleEarth.isStopHotFlash = true;
                        playEarth();
                        //停止定时器
                        dtd.Stop();
                    }
                });//调用函数
                dtd.Start();
            }
            catch (Exception ee) {
                LogUtil.debug("详细页面 error:" + ee.StackTrace);
            }
        }

        /// <summary>
        /// 开始播放控制
        /// </summary>
        public void control()
        {
            playIndex();
        }
    }
}
