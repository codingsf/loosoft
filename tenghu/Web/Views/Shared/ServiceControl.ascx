<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#E8E8E8" style="border-collapse:collapse;">
                  <tr>
                    <td width="17%" height="30" class="txl01"><strong>国家</strong></td>
                    <td width="20%" class="txl01"><strong>地区</strong></td>
                    <td width="48%" class="txl01"><strong>名称</strong></td>
                    <td width="15%" class="txl01"><strong>查看详细</strong></td>
                    </tr>
                    
                    <%
                        bool issale = bool.Parse(ViewData["issale"].ToString());
                        int i = 0;
                        foreach (var item in ViewData["data"] as IList<Cn.Loosoft.Zhisou.Tenghu.Domain.ServiceInfo>)
                      {
                          if (item.issale.Equals(issale))
                              continue;
                          i++;
                            %>
                  <tr onmouseover="this.style.backgroundColor ='#ccc';" onmouseout="this.style.backgroundColor ='';" style="cursor:pointer" onclick="$('#td<%=item.id %>').toggle();changePoint(<%=item.latitude %>,<%=item.longitude %>,'<%=item.addr %><br/><br/><%=item.tel %>');">
                    <td height="30" class="txl03">中国</td>
                    <td width="20%" class="txl03"><%=item.area %></td>
                    <td width="48%" class="txl03"><%=item.addr %></td>
                    <td width="15%" class="txl03"><img src="/img/ny/cx01.gif" width="16" height="16" border="0" /></td>
                  </tr>
                  <tr id="td<%=item.id %>" style="display:none">
                  <td colspan="4"  style="padding-left:20px">
                  <strong>名称:</strong><%=item.addr %><br />
                  <strong>邮编:</strong><%=item.post %><br />
                  <strong>电话:</strong><%=item.tel %><br />
                  <strong>简介:</strong><%=item.descr %>
                  </td>
                  </tr>
                  <%} %>
                  
                  <%if (i.Equals(0))
                    { %>
                <tr> <td colspan="4" align="left">   暂时没有相关数据，请您放大检索条件再次检索！</td> </tr>
                    <%} %>
                </table>