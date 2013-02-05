<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.Tenghu.Service" %>
<%@ Import Namespace="DataLinq" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">

 
 


</head>
<body>
<%   var categories = ViewData["data"] as IList<DataLinq.Category>;
     foreach (DataLinq.Category category in categories)
         Response.Write(category.name);%>
    
</body>

</html>
