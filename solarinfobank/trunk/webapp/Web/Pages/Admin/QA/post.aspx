<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.QA>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    最新提问 - SolarInfoBank
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
                <td width="8">
                    <img src="/images/kj/kjico02.jpg" width="8" height="63" />
                </td>
                <td width="777">
                    <table width="98%" height="45" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="7%" rowspan="2" align="center">
                                <img src="/images/kj/kjiico01.gif" />
                            </td>
                            <td width="93%" class="pv0216">
                                最新提问
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="6" align="right">
                    <img src="/images/kj/kjico03.jpg" width="6" height="63" />
                </td>
            </tr>
        </table>
        <div class="find_yqi">
            <form method="post" action="/admin/postanswer">
            <div class="subrbox01">
                <div>
                    <table width="90%" height="30" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="/images/sub/subico010.gif" width="18" height="19" />
                            </td>
                            <td width="94%" class="f_14">
                                <strong>最新提问</strong>
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
                            <td width="10%" height="35" class="pl20">
                                问题：
                            </td>
                            <td width="71%" colspan="2">
                                <input name="qid" type="hidden" value="<%=Model.id %>" />
                                <input name="id" type="hidden" value="<%=Model.isanswered?Model.answerslist[0].id:0 %>" />
                                <%=Model.title %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <p>
                                    <%=Model.descr %>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <p>
                                    <textarea name="descr" cols="55" rows="10"><%=Model.isanswered?Model.answerslist[0].descr:"" %></textarea>
                                </p>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sb_down">
                </div>
            </div>
            <div>
                <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr>
                            <td>
                                <input name="Submit" class="txtbu03" value=" 保存 " type="submit">
                            </td>
                            <td>
                                <input name="Submit2" onclick="window.location='/admin/answer/'" class="txtbu03"
                                    value=" 取消 " type="button">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </form>
        </div>
    </td>
</asp:Content>
