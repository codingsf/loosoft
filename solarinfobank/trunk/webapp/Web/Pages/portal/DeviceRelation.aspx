<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>设备接线图
        <%=Model.name%></title>
    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <script>
        function iFrameHeight() {
            //set current page title 
            document.title = (document.getElementById('mainFrame').contentWindow.document.title);
            var ifm = document.getElementById("mainFrame");
            var subWeb = document.frames ? document.frames["mainFrame"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }
    </script>

    <script src="../../script/dtree.js" type="text/javascript"></script>

    <link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=Model.name %>
                </div>
                <div class="gf_toptittle2">
                    <a href="/portal/index">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div style="clear: both; height: 10px;">
            </div>
            <div style="float: left; width: 20%;">
                <script type="text/javascript">
		<!--

                            d = new dTree('d');
                            d.add(0, -1, '设备接线图');
                            <% IList<DeviceRelation> relations= ViewData["group"] as IList<DeviceRelation>;
                             int i = 1;
                           foreach (DeviceRelation relation in relations)
                           { %>
                            d.add(<%=i++ %>, 0, '<%=relation.name%>', '/portal/devicerelation?pid=<%=ViewData["pid"] %>&name=<%=relation.name%>' ,'', '', '/images/tree/folder.gif');
                            <%} %>
                            document.write(d);

		//-->
                </script>
                <% string firstGroup = relations != null && relations.Count > 0 ? relations[0].name : string.Empty; %>
            </div>
            <div style="float: right; width: 75%;">
                <iframe id="mainFrame" height="600" src="/plant/relationchart/<%= ViewData["pid"] %>?portal=true&name=<%=Request["name"]==null?firstGroup:Request["name"] %>"
                    width="100%" scrolling="no" frameborder="0" style="text-align: center;"></iframe>
            </div>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>
