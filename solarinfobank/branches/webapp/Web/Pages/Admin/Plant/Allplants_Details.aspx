<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Common.ExcelData>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<style>
    .exa_plant
    {
        color: Red;
    }
</style>
<style type="text/css">
<!--
.am_line01{ border-bottom:1px solid #E9E9E9; line-height:25px; background:#F7F7F7; text-align: center;}
.am_line00{ border-bottom:1px solid #DFDFDF; line-height:25px; background:#fff; text-align: center}
.lir{ background:url(//images/am/ad_line.gif) right no-repeat;}
-->
</style>
<div style="overflow: auto; width:720px;height:400px;">
    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD"
        style="border-collapse: collapse; line-height: 24px; text-align: center;overflow-x: auto;   width: <%=Model.Rows.Count>0? (Model.Rows[0].Count*100).ToString()+"px":"100%" %>"">
        <%
            int x = 0;
            foreach (IList<string> strArray in Model.Rows)
            {
                string[] arr = strArray[strArray.Count - 1].Split(':');
                if (arr.Length.Equals(3) && arr[1].ToLower().Equals("true"))
                    Response.Write("<tr class=\"exa_plant\">");
                else
                    Response.Write("<tr>");
                x++;

                if (x.Equals(Model.Rows.Count))//最后一行统计信息不显示
                    continue;

                for (int t = 0; t < strArray.Count - 1; t++)
                {
                    if (x.Equals(1) || x.Equals(Model.Rows.Count))
                        Response.Write(string.Format("<td  height=\"35\" bgcolor=\"#F3F3F3\" width=\"100px\">{0}</td>", strArray[t]));
                    else
                        Response.Write(string.Format("<td height=\"35\" >{0}</td>", strArray[t]));
                }

                if (x.Equals(1))
                    Response.Write("<td height=\"35\" width=\"200\"  bgcolor=\"#F3F3F3\" >操作 </td>");
                else
                {
                    Response.Write("<td height=\"35\" width=\"200\">");
                    if (!x.Equals(Model.Rows.Count))
                    {
                        if (AuthService.isAllow("admin", "recommend"))
                        {
                            if (arr.Length.Equals(3) && arr[1].ToLower().Equals("true"))//实例电站
                                Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"delrecommend('{0}')\"><img src=\"/images/sub/noagree.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"取消示例电站\" title=\"取消示例电站\" /></a>", arr[0]));
                            else
                                Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"recommend('{0}')\"><img src=\"/images/sub/agree.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"推荐为示例电站\" title=\"推荐为示例电站\" /></a>", arr[0]));
                        }
                        if (AuthService.isAllow("admin", "newplant"))
                        {
                            if (arr.Length.Equals(3) && arr[2].ToLower().Equals("true"))//首页显示
                                Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"delnewplant('{0}')\"><img src=\"/images/sub/qx01.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"取消首页显示\" title=\"取消首页显示\" /></a>", arr[0]));
                            else
                                Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"newplant('{0}')\"><img src=\"/images/sub/qx02.gif\" width=\"16\" height=\"16\" border=\"0\" alt=\"推荐首页显示\" title=\"推荐首页显示\" /></a>", arr[0]));

                        }
                        if (AuthService.isAllow("admin", "delplant"))
                        {
                            Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"delplant('{0}')\"><img src=\"/images/sub/cross.gif\" alt=\"删除电站\" title=\"删除电站\" ></a>", arr[0]));
                        }
                        else
                            Response.Write("<img src=\"/images/sub/nodelete.gif\" alt=\"删除电站\" title=\"删除电站\" >");

                        if (AuthService.isAllow("admin", "anonymous"))
                        {
                            Response.Write(string.Format("<a href=\"javascript:void(0)\" onclick=\"anonymous('{0}')\"><img src=\"/images/sub/iji.jpg\" alt=\"匿名访问\" title=\"匿名访问\" ></a>", arr[0]));
                        }
                    }
                    Response.Write("</td>");
                }
                Response.Write("</tr>");
            }%>
    </table>
</div>
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD"
    style="border-collapse: collapse; line-height: 24px; text-align: center">
    <tr>
        <td height="40">
            <%Html.RenderPartial("page"); %>
        </td>
    </tr>
</table>
