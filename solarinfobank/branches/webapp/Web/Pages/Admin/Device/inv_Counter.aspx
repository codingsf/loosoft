<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Common.ExcelData>" %>

<div style="overflow: auto">
    <table border="1" cellpadding="0" cellspacing="0" bordercolor="#DDDDDD" style="border-collapse: collapse;
        line-height: 24px; text-align: center; width: 100%;">
        <%
            int x = 0;

            for (int i = Model.Rows.Count - 1; i < Model.Rows.Count ; i++)//最后一行统计不显示
            {
                Response.Write("<tr>");
                x++;
                foreach (string str in Model.Rows[i])
                {
                    if (string.IsNullOrEmpty(str))
                        continue;
                    if (x.Equals(1))
                        Response.Write(string.Format("<td height=\"35\" bgcolor=\"#F3F3F3\" style=\"width:100px\">{0}</td>", str));
                    else
                        Response.Write(string.Format("<td height=\"35\">{0}</td>", str));

                }
                Response.Write("</tr>");
            }%>
    </table>
</div>

