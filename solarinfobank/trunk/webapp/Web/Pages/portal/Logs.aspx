<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.Plant>" %>

<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Service" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>光伏电站监控</title>

    <script src="../../script/jquery-1.3.2.min.js" type="text/javascript"></script>

    <link href="../../style/mhcss.css" rel="stylesheet" type="text/css" />

    <script src="../../script/DatePicker/WdatePicker.js" type="text/javascript"></script>

    <script language="javascript">
        var pageNo = 1;
        var ttl1 = ' <%= Resources.SunResource.USER_LOG_SELECT_ALL%>';
        var ttl2 = ' <%= Resources.SunResource.PLANT_LOG_SELECT%>';
        var ttl3 = '% <%= Resources.SunResource.USER_LOG_SELECTED%> ';
        $(document).ready(function() {
            $("#errorCode").multiSelect();
            changePage(1);
        });
        function cbxvalue(name) {
            var values = "";
            $("input[name='" + name + "']:checked").each(function() {
                values += $(this).val() + ",";
            });
            return values == "" ? '-1,' : values;
        }

        function changePage(no) {
            pageNo = no;
     $.ajax({
                type: "POST",
                url: "/portal/searchlogs",
                data: {userId:'<%=ViewData["uid"] %>',startDate: $("#startDate").attr("value"), endDate: $("#endDate").attr("value"), state: $("#state").val(), plant: <%=Request["pid"]==null?"-1":Request["pid"]%>, pindex: pageNo, errorType: cbxvalue('errorCode'),ctype: $("#ctype").val() },
                success: function(result) {
                    $('#result').append(result)
                },
                beforeSend: function() {
                    $('#result').empty()
                }
            });
        }
    </script>

</head>
<body style="background: url(/images/gf/gf_tcbg.jpg) top repeat-x;">
    <div class="gf_boxb">
        <div class="gf_top">
            <div class="gf_toptittle">
                <div class="gf_toptittlen">
                    <%=ViewData["name"] %></div>
                <div class="gf_toptittlel">
                    <a href="#">
                        <img src="<%=ViewData["logo"] %>" border="0" /></a></div>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="gf_midbody">
        <div class="gf_boxb">
            <div>
                <div style="text-align: center">
                </div>
                <div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15%" height="26">
                                <table width="200" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="17%" align="center">
                                            <img src="/images/gf/subico010.gif" width="18" height="19" />
                                        </td>
                                        <td width="83%">
                                            <strong>筛选条件</strong>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table width="98%" height="30" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" align="right" class="gfpr">
                                开始日期:
                            </td>
                            <td width="12%">
                                <input id="startDate" name="startDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                    readonly="readonly" size="15" value="2012-05-07" class="txtbu04 Wdate" type="text">
                            </td>
                            <td width="7%" align="right" class="gfpr">
                                结束日期:
                            </td>
                            <td width="12%">
                                <input id="endDate" name="endDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,lang:'zh-cn'})"
                                    readonly="readonly" size="15" value="2012-05-08" class="txtbu04 Wdate" type="text">
                            </td>
                            <td width="5%" align="right" class="gfpr">
                                状态:
                            </td>
                            <td width="13%">
                                <select name="state" id="state" class="txtbu01" style="width: 120px;">
                                    <option value="0">未确认</option>
                                    <option value="1">确认</option>
                                    <option value="-1">所有</option>
                                </select>
                            </td>
                            <td width="4%" align="right" class="gfpr">
                                类型:
                            </td>
                            <td width="10%">
                                <select id="errorCode" multiple="multiple" name="errorCode" class="txtbu01" size="5"
                                    style="width: 110px">
                                    <option value="">
                                        <%=Resources.SunResource.USER_LOG_SELECT %>
                                    </option>
                                    <% foreach (ErrorType errorType in ViewData["errorTypes"] as ICollection<ErrorType>)
                                       { %>
                                    <option value="<%=errorType.code %>">
                                        <%=errorType.name%></option>
                                    <%} %>
                                </select>
                            </td>
                            <td width="10%" align="right">
                                <input name="Submit" type="submit" class="subbu01" value="查询" onclick="changePage(pageNo)" />
                            </td>
                        </tr>
                    </table>
                    <div id="result">
                    </div>
                </div>
            </div>
            <p>
                &nbsp;</p>
            <p>
                &nbsp;</p>
            <p>
                &nbsp;</p>
            <p>
                &nbsp;</p>
            <div style="clear: both; height: 60px;">
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <%Html.RenderPartial("footer"); %>
    
</body>
</html>

<script src="../../script/jquery.multiSelect.js" type="text/javascript"></script>

<link href="../../style/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
