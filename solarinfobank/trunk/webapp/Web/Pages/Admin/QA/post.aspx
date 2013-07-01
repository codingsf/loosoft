<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/Shared/BackManager.Master"
    Inherits="System.Web.Mvc.ViewPage<Cn.Loosoft.Zhisou.SunPower.Domain.QA>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    最新提问 - SolarInfoBank
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <script src="/script/jquery.js" type="text/javascript"></script>

    <script src="/script/jquery.validate.js" type="text/javascript"></script>

    <script>
        function checkwords(obj) {
            var content = obj.value;
            var length = 500 - content.length;
            if (length <= 0) {
                obj.value = content.substr(0, 500);
                length = 0;
            }
            document.getElementById("wordLength").innerHTML = length;

        }
    </script>

    <script type="text/javascript">
        function checkform() {
            var content = document.getElementById("descr").value;
            if (content == "") {
                alert('请输入评论内容'); return false;
            }
        }
        $().ready(function() {
            checkwords(document.getElementById('descr'));
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

    <td width="793" valign="top" background="/images/kj/kjbg01.gif">
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
                                FAQ
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
                                <strong>回答问题</strong>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="sb_top">
                </div>
                <div class="sb_mid">
                    <div class="note01">
                        提示:* 为必填项目</div>
                    <div class="faq_ask">
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
                                <td class="pl20" height="35">
                                </td>
                                <td colspan="2">
                                    <p>
                                        <%=Model.descr %>
                                    </p>
                                </td>
                            </tr>
                            <tr>
                                <td class="pl20" height="35">
                                    提问人
                                </td>
                                <td colspan="2">
                                    <%=Model.username %>
                                </td>
                            </tr>
                            <tr>
                                <td class="pl20" height="35">
                                    提问时间
                                </td>
                                <td colspan="2">
                                    <%=Model.pubdate.ToString("yyyy-MM-dd HH:mm") %>
                                </td>
                            </tr>
                            <%if (Model.isanswered)
                              { %>
                            <tr>
                                <td class="pl20" height="35">
                                    回答人
                                </td>
                                <td colspan="2">
                                    <%=Model.answerUserName%>
                                </td>
                            </tr>
                            <%} %>
                            <tr>
                                <td class="pl20">
                                    答复<span class="red">*</span>
                                </td>
                                <td style="padding-top: 10px;" colspan="2">
                                    <textarea onkeyup="checkwords(this);" name="descr" id="descr" class="txtbu05" class="faq_input02"
                                        style="width: 400px; font-size: 12px; color: #999999;"><%=Model.isanswered?Model.answerslist[0].descr:"" %></textarea>
                                    <span style="line-height: 25px; height: 25px; display: block; color: #999999;">还可输入<span
                                        id="wordLength">500</span>个字</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="sb_down">
                </div>
            </div>
            <div>
                <table width="350" height="60" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tbody>
                        <tr>
                            <td>
                                <input name="Submit" class="txtbu03" value=" 保存 " onclick="return checkform();" type="submit">
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
