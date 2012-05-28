<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.User>" %>
<%@ Register Namespace="System.Web.UI.DataVisualization.Charting" Assembly="System.Web.DataVisualization,Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" TagPrefix="asp" %>

  <%
      IList<KeyValuePair<string, float?>> chartData = ViewData["Chart"] as IList<KeyValuePair<string, float?>>;
        Chart Chart2 = new Chart();

        Chart2.Width = 275;
        Chart2.Height = 210;
        //Title title = new Title(ViewData["name"].ToString(), Docking.Top, new System.Drawing.Font("Trebuchet MS", 12, System.Drawing.FontStyle.Regular), System.Drawing.Color.FromArgb(26, 59, 105));
        Title title = new Title(ViewData["name"] + "  " + ViewData["unit"], Docking.Top, new System.Drawing.Font("Trebuchet MS", 12, System.Drawing.FontStyle.Regular), System.Drawing.Color.FromArgb(26, 59, 105));
        Chart2.Titles.Add(title);
        Chart2.ChartAreas.Add("Series 1");
        Chart2.ChartAreas[0].AxisX.Interval = 12;
        Chart2.ChartAreas[0].AxisY.IntervalAutoMode=IntervalAutoMode.VariableCount;
        Chart2.ChartAreas[0].AxisX.MajorTickMark.Interval = 12;
        Chart2.ChartAreas[0].AxisX.IntervalOffset = 0;
        Chart2.ChartAreas[0].AxisX.IsMarginVisible = false;
        //Chart2.ChartAreas[0].AxisY.Title = string.Format("[{0}]", ViewData["unit"].ToString());
        Chart2.ChartAreas[0].AxisX.MinorGrid.LineWidth = 0;
        Chart2.ChartAreas[0].AxisX.LabelStyle.Angle = -90;
        Chart2.Series.Add("Series 1");
        Chart2.Series.Add("Series 2");
      
        Chart2.Series[0].Points.DataBind(chartData, "key", "value", "");
        Chart2.Series[0].XValueType = ChartValueType.String;
        Chart2.Series[0].Color = System.Drawing.Color.FromArgb(239, 88, 8);
        Chart2.Series[0].ChartType = SeriesChartType.Line;
        Chart2.BorderSkin.SkinStyle = BorderSkinStyle.None;
        Chart2.Page = this;
        HtmlTextWriter writer = new HtmlTextWriter(Page.Response.Output);
        Chart2.RenderControl(writer);
    %>