<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.ItemConfig>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    等效树木设置 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script type="text/javascript">

        $().ready(function() {
            $("#editForm").validate({
                errorElement: "em",
                rules: {
                    value: {
                        required: true
                    }
                },
                errorPlacement: function(error, element) {
                    if (element.attr("name") == "value") {
                        $("#error_value").text('');
                        error.appendTo("#error_value");
                    }
                },

                messages: {
                    value: {
                    required: "<span class='error'>&nbsp;请输入值</span>"
                    }
                },
                success: function(em) {
                    //em.html('<span class="success">&nbsp;<%=Resources.SunResource.ADMIN_DBCONFIG_EDIT_SUCCESS_EM %></span>');
                }
            });

        });
    </script>

    <td width="793" valign="top" background="/images/kj/kjbg01.jpg">
        <table width="100%" height="63" border="0" cellpadding="0" cellspacing="0" background="/images/kj/kjbg02.jpg">
          <tr>
            <td width="8"><img src="/images/kj/kjico02.jpg" width="8" height="63" /></td>
            <td width="777"><table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="7%" rowspan="2" align="center"><img src="/images/kj/kjiico01.gif"/></td>
                  <td width="93%" class="pv0216">等效树木设置</td>
                </tr>
                <tr>
                  <td>  &nbsp;</td>
                </tr>
            </table></td>
            <td width="6" align="right"><img src="/images/kj/kjico03.jpg" width="6" height="63" /></td>
          </tr>
        </table>
        <div class="find_yqi">
            <% using (Html.BeginForm("tree", "itemconfig", FormMethod.Post, new { @id = "editForm", name = "editForm" }))
               {%>
            <div class="subrbox01">
                <div>
                    <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td width="94%" class="f_14">
                                <strong> 等效树木设置</strong>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sb_top">
                </div>
                <div class="sb_mid">
                    <div class="note01">
                       提示:* 为必填项目</div>
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                        <tr>
                            <td width="29%" height="35" class="pl20">
                                等效树木设置：
                            </td>
                            <td width="36%">
                                <%=Html.TextBoxFor(model => model.value)%> Kg 
                                <span class="red">*</span>
                                <%= Html.HiddenFor(model => model.type)%>
                                <%= Html.HiddenFor(model => model.id)%>
                                <%= Html.HiddenFor(model => model.name)%>
                            </td>
                            <td width='35%'>
                                <span id="error_value"></span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sb_down">
                </div>
            </div>
            <div>
                <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <input name="button2" type="submit" class="txtbu03" id="Submit1" value=" 保存 " />
                        </td>
                    </tr>
                </table>
            </div>
            <%} %>
        </div>
    </td>
</asp:Content>
