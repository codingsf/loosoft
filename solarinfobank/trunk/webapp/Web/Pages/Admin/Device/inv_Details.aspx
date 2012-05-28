<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Common.ExcelData>" %>

<div style="overflow: auto; float:left; width:720px;height:500px;">
    <table border="1" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD" style="border-collapse: collapse;
        line-height: 24px; text-align: center;overflow-x: auto;  width: <%=Model.Rows.Count>0? (Model.Rows[0].Count*100).ToString()+"px":"100%" %>">
        <%
            int x = 0;
            for (int i = 0; i < Model.Rows.Count-1; i++)//最后一行统计不显示
            {
                Response.Write("<tr>");
                x++;
                foreach (string str in Model.Rows[i])
                {
                    if (x.Equals(1))
                    {
                        if(str.Equals("所属电站"))
                            Response.Write(string.Format("<td height=\"35\" bgcolor=\"#F3F3F3\" style=\"width:100px\"><a href='javascript:void(0)' onclick=\"orderby('pltname');\">{0}</a></td>", str));
                        else
                            if (str.Equals("设备型号"))
                                Response.Write(string.Format("<td height=\"35\" bgcolor=\"#F3F3F3\" style=\"width:100px\"><a href='javascript:void(0)' onclick=\"orderby('dtype');\">{0}</a></td>", str));
                            else
                                Response.Write(string.Format("<td height=\"35\" bgcolor=\"#F3F3F3\" style=\"width:100px\">{0}</td>", str));
                                
                    }
                    else
                        Response.Write(string.Format("<td height=\"35\">{0}</td>", str));

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
