<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master" %>

<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Common" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
   清理数据 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="/script/jquery.js" type="text/javascript"></script>
    <script src="/script/jquery.validate.js" type="text/javascript"></script>
    <script src="/script/DatePicker/WdatePicker.js" type="text/javascript"></script>    
    <script type="text/javascript">
        $().ready(function() {
            $("#addForm").validate({
                errorElement: "em",
                rules: {
                    sn: {
                        required: true
                    },

                    startDate: {
                        required: true
                    },
                    endDate: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (document.getElementById("error_" + element.attr("name"))) {
                        error.appendTo("#error_" + element.attr("name"));
                    }
                    else
                        error.insertAfter(element);
                        
                },
                submitHandler: function(form) {
                    if(confirm("请确认要按此条件清理?"))
				        ajaxClear();
				},
                messages: {
                    sn: {
                        required: "<span class='error'>&nbsp;请输入采集器序列号</span>"
                    },
                    startDate: {
                        required: "<span class='error'>&nbsp;请输入开始时间</span>"
                    },
                    endDate: {
                        required: "<span class='error'>&nbsp;请输入截止时间</span>"
                    }
                },
                success: function(em) {
                    //alert(em)
                }
            });

        });
        
        function ajaxClear() {
            $.ajax({
                type: "POST",
                url: "/admin/clearHandle",
                data: { sn: $("#sn").val(), startDate: $("#startDate").val(), endDate: $("#endDate").val() },
                success: function(result) {
                    $("#em").html(result);
                },
                beforeSend: function() {
                    $('#em').empty();
                    $('#em').append("正在处理，请稍后！");
                }
            });
        }
    </script>
<td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">清理数据</td>
                </tr>
                <tr>
                  <td></td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="find_yqi">
            <% using (Html.BeginForm("clearhandle", "admin", FormMethod.Post, new { @id = "addForm", name = "addForm" }))
               {%>
            <table width="688" border="0" align="center" cellspacing="0">
                <tr>
                    <td class="bzptb">
                        <table width="90%" border="0" align="center" cellspacing="0">
                            <tr>
                        <td width="27%" height="36" class="tdflr" align=right>
                            &nbsp;
                        </td>
                        <td width="73%" id="em" align=left>
                            &nbsp;
                        </td>      
                        </tr>                  
                        <tr>
                        <td width="27%" height="36" class="tdflr" align=right>
                            采集器sn：
                        </td>
                        <td width="73%">
                            <input type="text" id="sn" name="sn" value="" />
                            <span  id="error_sn"></span>
                        </td>
                    </tr>
                    <tr>
                        <td height="36" class="tdflr" align=right>
                            开始日期：
                        </td>
                        <td>
                            <input type="text" id="startDate" name="startDate" value="" onfocus="WdatePicker({skin:'whyGreen',lang:'zh-cn'})" />
                            <span id="error_startDate"></span>
                        </td>
                    </tr>
                   <tr>
                        <td height="36" class="tdflr" align=right>
                            截止日期：
                        </td>
                        <td>
                            <input type="text" id="endDate" name="endDate" value="" onfocus="WdatePicker({skin:'whyGreen',lang:'zh-cn'})"/>
                            <span id="error_endDate"></span>
                        </td>
                    </tr>                                                         
                    <tr>
                        <td height="40" class="tdflr" align="right">

                        </td>
                        <td>
                            <input name="Submit" type="submit" class="subbu01" value="开始清理" />&nbsp;
                        </td>
                    </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <%} %>
        </div>
    </td>
</asp:Content>
