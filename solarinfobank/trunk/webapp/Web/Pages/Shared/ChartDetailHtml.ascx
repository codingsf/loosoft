<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Cn.Loosoft.Zhisou.SunPower.Common.ChartData>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>
        <%=Cn.Loosoft.Zhisou.SunPower.Service.UserUtil.getCurUser().organize %>
        <%=Model.name %>  <%=Resources.SunResource.DETAIL%></title>
    <style type="text/css">
        .line_b
        {
            border-bottom: 1px solid #9EC93D;
        }
        body
        {
            background: #F7F7F7;
        }
        .fr30
        {
            float: right;
            padding-right: 20px;
        }
        .fl30
        {
            float: left;
            padding-left: 20px;
        }
    </style>
</head>
<link href="/style/css.css" rel="stylesheet" type="text/css" />
<link href="/style/sub.css" rel="stylesheet" type="text/css" />
<link href="/style/kj.css" rel="stylesheet" type="text/css" />
<body>
    <div class="mainbody">
        <% 
     
            string unit = string.Empty;
            bool isprocessUnit = true;
            int firsIndex = Model.series[0].name.IndexOf('[');
            int lastIndex = Model.series[0].name.LastIndexOf(']');
            if (Model.units.Count().Equals(1) || Model.units.GroupBy(m => m.ToString()).Count().Equals(1))//只有一个项目或者所有单位相同
            {
                unit = Model.units[0];
                isprocessUnit = false;
            }
    
        %>
   
  <div style="background: url(/images/tc_topbg.jpg); height: 57px;">
<div style="float:left; height:57px; line-height:50px; padding:0px 0px 0px 20px; width:300px;"> &nbsp;<a href="#"><img src="<%= UserUtil.UserLogo %>" width="168" height="27" border="0" style="vertical-align:middle;"/></a></div>
<div style="float:right; padding-right:10px; line-height:55px; font-size:18px;"><%= UserUtil.SysName %></div>
</div>

        <!--main开始-->
        <div style="padding: 30px 0px 80px 0px; margin: 0px auto; width: 98%;">
            <div>
                <div style="line-height: 36px;padding-left:10px;">
                                <strong>
                                    <%=Model.name %><%=Resources.SunResource.DETAIL%>
                                </strong>
                                <%= isprocessUnit==false? string.Format("[{0}]", unit):string.Empty %></div>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="9" height="9" background="/images/tc01.gif">
                        </td>
                        <td background="/images/tc02.gif">
                        </td>
                        <td width="9" height="9" background="/images/tc03.gif">
                        </td>
                    </tr>
                    <tr>
                        <td background="/images/tc04.gif">
                            &nbsp;
                        </td>
                        <td bgcolor="#FFFFFF">
                        
                            <table width="100%" cellpadding="0" cellspacing="0" style="line-height: 24px; text-align: center">
                                <tr>
                                    <td width="200" background="images/flrg.jpg" bgcolor="#F3F3F3" class="lbtt">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" background="images/flrg.jpg">
                                            <tr>
                                                <td align="left">
                                                    <strong style="padding-left: 20px;">
                                                        <%=(Model.names.Length>0 && !string.IsNullOrEmpty(Model.names[0])) ? Model.names[0] + "[" + Model.units[0] + "]" : Resources.SunResource.CUSTOMREPORT_CHART_TIME%>
                                                    </strong>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <%
                                        int yy = DateTime.Now.Year;
                                        int mm = DateTime.Now.Month;
                                        int dd = DateTime.Now.Day;
                                        int hh = DateTime.Now.Hour;
                                        int MM = DateTime.Now.Minute;
                                        int ss = DateTime.Now.Second;

                                        string date = ViewData["date"] == null ? string.Empty : ViewData["date"].ToString();
                                        date = date.Equals("undefined") ? string.Empty : date;

                                        if (Regex.IsMatch(date, "^\\d{10}$"))//日请求数据
                                        {
                                            yy = int.Parse(date.Substring(0, 4));
                                            mm = int.Parse(date.Substring(4, 2));
                                            dd = int.Parse(date.Substring(6, 2));
                                        }
                                        else
                                            if (Regex.IsMatch(date, "^\\d{8}$"))//月请求数据
                                            {
                                                yy = int.Parse(date.Substring(0, 4));
                                                mm = int.Parse(date.Substring(4, 2));
                                            }
                                            else
                                                if (Regex.IsMatch(date, "^\\d{4}$"))//年请求数据
                                                {
                                                    yy = int.Parse(date);
                                                }

                                        IList<int> years = new List<int>();
                                        for (int x = 0; x < Model.series.Count(); x++)
                                        {

                                            string name = Model.series[x].name;
                                            name = name.Contains('-') ? name.Substring(0, name.LastIndexOf('-')) : name;
                                            if (name.Contains('['))
                                                name = isprocessUnit == false ? name.Substring(0, name.IndexOf('[')) : name;
                                            name = name.Replace("-", " ");
                                            if (Regex.IsMatch(name, "^\\d{4}$"))//多年比较 
                                                years.Add(int.Parse(name));
                                    %>
                                    <td bgcolor="#F3F3F3" class="lbtt" align="center">
                                        <strong >
                                            <%=name%>
                                        </strong>
                                    </td>
                                    <%} %>
                                </tr>
                                <%
                                    int y = 0;
                                    for (; y < Model.categories.Count(); y++)
                                    {
                                        string dStr = Model.categories[y];
                                        //空值继续
                                        if (string.IsNullOrEmpty(dStr) || "0".Equals(dStr)) continue;
                                        if (Regex.IsMatch(dStr, "^\\d{2}:\\d{2}/\\d{2}$"))//日请求数据
                                        {
                                            dd = int.Parse(dStr.Substring(6, 2));
                                            hh = int.Parse(dStr.Substring(0, 2));
                                            MM = int.Parse(dStr.Substring(3, 2));
                                        }
                                        else
                                            if (Regex.IsMatch(dStr, "^\\d{2}$"))//月请求数据
                                            {
                                                dd = int.Parse(dStr.Substring(0, 2));
                                            }
                                            else
                                            {
                                                if (Regex.IsMatch(dStr, "^\\d{4}$"))//总请求数据 
                                                {
                                                    yy = int.Parse(dStr);
                                                }
                                                else if (Regex.IsMatch(dStr.ToLower(), "^[a-z]*$") || date.Length == 4 || date == string.Empty)
                                                {
                                                    mm = y + 1;
                                                }

                                            }
                                        switch (mm)
                                        {
                                            case 2:
                                                dd = dd > 28 ? 28 : dd;
                                                break;
                                            case 4:
                                            case 6:
                                            case 9:
                                            case 11:
                                                dd = dd > 30 ? 30 : dd;
                                                break;
                                        }
                                        DateTime dNow = DateTime.Now;
                                        try
                                        {
                                            dNow = new DateTime(yy, mm, dd, hh, MM, ss);
                                        }
                                        catch (Exception ee) {
                                        }
                                        
                                %>
                                <tr>
                                    <td class="down_line02">
                                        <span class="fl30">
                                            <%=dStr%></span>
                                    </td>
                                    <%
                                        int index = 0;
                                        while (index++ < Model.series.Count())
                                        {
                                            if (years.Count > 1)//说明多年比较
                                                dNow = new DateTime(years[index - 1], mm, dd, hh, MM, ss);
                                    %>
                                    <td class="down_line02" align="center">
                                   
                                            <%=Model.series[index - 1].data[y] == null ? dNow < DateTime.Now ? "None" : "&nbsp;" : ((double)Model.series[index - 1].data[y]).ToString("0.00")%>
                                    </td>
                                    <%  } %>
                                </tr>
                                <%  }%>
                            </table>
                        </td>
                        <td background="/images/tc05.gif" >
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
        <td width="9" height="9"><img src="/images/tc/tc06.gif" width="9" height="9" /></td>
        <td background="/images/tc/tc07.gif"></td>
        <td><img src="/images/tc/tc08.gif" width="9" height="9" /></td>
      </tr>
                </table>
            </div>
        </div>
        <!--结束-->
        <div style="clear: both">
        </div>
        <!--footer开始-->
        <div style="width: 100%; background: url(images/fbg.jpg); height: 34px; line-height: 34px;
            margin-top: 10px; text-align: center; color: #7E7E7E; margin: 0px auto;">
            <span>
                <%= string.Format( Resources.SunResource.SHARED_MAINMASTREPAGE_COPYRIGHT, UserUtil.SysName)%></span>
        </div>
        <!--结束-->
    </div>
</body>
</html>
