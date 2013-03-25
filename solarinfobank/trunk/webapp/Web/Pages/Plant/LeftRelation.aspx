<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<IList<Hashtable>>" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<%@ Import Namespace="System.Globalization" %>
<script src="../../script/dtree.js" type="text/javascript"></script>
<script src="../../script/jquery.js" type="text/javascript"></script>
<link href="../../style/dtree.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
d = new dTree('d');
<%=ViewData["jsstr"] %>
document.write(d);
d.openAll();

parent.iFrameHeight();
parent.iFrameHeight1();
function autoIframeHeight()
{
    parent.iFrameHeight();
    parent.iFrameHeight1();
    parent.parent.iFrameHeight();
}
setInterval("autoIframeHeight()",1000); 

function setPara(_id,_isunit,_unitid)
{
    parent.setLeft(_id,_isunit,_unitid);
}

</script>

