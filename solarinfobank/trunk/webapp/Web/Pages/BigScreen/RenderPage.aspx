<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%int index = int.Parse(ViewContext.RouteData.Values["id"].ToString());
  string plantid = ViewContext.RouteData.Values["plantid"].ToString();
  switch (index)
  {
      case 0:
          Html.RenderAction("profile",new { @id = index, @plantid = plantid });
          break;
      case 1:
          Html.RenderAction("powerchart", new { @id = index, @plantid = plantid });
          break;
      case 2:
          Html.RenderAction("monthenergychart", new { @id = index, @plantid = plantid });
          break;
      case 3:
          Html.RenderAction("yearenergychart", new { @id = index, @plantid = plantid });
          break;
  } %>
