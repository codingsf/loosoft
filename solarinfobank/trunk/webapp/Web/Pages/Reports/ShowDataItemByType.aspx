<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ReportDataItem>" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<script type="text/javascript">
    function getItemCode() {
        var items = document.getElementsByName("itemName");
        var str="";
        for (var i = 0; i < items.length; i++) {
           if(items[i].checked) {
               str += items[i].value + ",";
           }
        }
        $("#dataitem").val(str.substring(0,str.length-1));
    }
</script>
<%=Html.Hidden("dataitem","") %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <%
      int i = 0;
      foreach (ReportDataItem item in (ViewData["list"] as List<ReportDataItem>))
      {
          if (DataItem.deviceDataItemMap.Contains(item.id)) continue;
          i++;
   %>
    <td height="40" width="4%" align="right">
    <input type="checkbox" name="itemName" id="<%=item.id%>" value="<%=item.id%>"/>&nbsp;
    </td>  
    <td height="40" width="28%" align=left>
    <%=DataItem.getNameByCode(item.id)%>
    </td>      
  <%   
  if (i % 3 == 0)
  {%>
     </tr> 
  <%}
      }%>  
      <tr><td colspan="10" style=" border-top:1px solid #e8e8e8; margin-left:20px;" >&nbsp;</td></tr>
        <tr>
   <%
      i = 0;
      foreach (ReportDataItem item in (ViewData["list"] as List<ReportDataItem>))
      {
          if (!DataItem.deviceDataItemMap.Contains(item.id))
              continue;
          i++;
   %>
    <td height="40" width="4%" align="right">
    <input type="checkbox" name="itemName" id="<%=item.id%>" value="<%=item.id%>"/>&nbsp;
    </td>  
    <td height="40" width="28%" align=left>
    <%=DataItem.getNameByCode(item.id)%>
    </td>      
  <%   
  if (i % 3 == 0)
  {%>
     </tr> 
  <%}
      }%>  
</table>