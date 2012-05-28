<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Cn.Loosoft.Zhisou.SunPower.Domain" %>







function Dsy()
{
this.Items = {};
}
Dsy.prototype.add = function(id,iArray)
{
this.Items[id] = iArray;
}
Dsy.prototype.Exists = function(id)
{
if(typeof(this.Items[id]) == "undefined") return false;
return true;
}

function change(v) {
var str="0";
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(s[i]).selectedIndex-1));};
var ss=document.getElementById(s[v]);
with(ss){
length = 0;
options[0]=new Option(opt0[v],opt0[v]);
if(v && document.getElementById(s[v-1]).selectedIndex>0 || !v)
{
if(dsy.Exists(str)){
ar = dsy.Items[str];
for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
if(v)options[1].selected = true;
}
}
if(++v<s.length){change(v);}
}
}

var dsy = new Dsy();



<% string s = "dsy.add(\"0\", [";
var other=Resources.SunResource.PLANT_COUNTRY_CITY_OTHER;
    foreach (var item in ViewData["countries"] as IList<CountryCity>)
  {
     s+=string.Format("\"{0}\",",item.name);
  }
    s+=string.Format("\"{0}\"]),",other);
    %>
<%=s %>

<% int i = 0;
   foreach (var item in ViewData["countries"] as IList<CountryCity>)
   {
       string temp = string.Format("dsy.add(\"0_{0}\", [", i++);
       foreach (var item1 in item.Cities)
       {
           temp += string.Format("\"{0}\",", item1.name);
       }
       temp+=string.Format("\"{0}\"]),",other);
       Response.Write(temp);
   }
   Response.Write(string.Format("dsy.add(\"0_{0}\", [\"{1}\"]);", i,other));
    %>
    

var s=["s1","s2"];
var opt0 = ["", ""];
function setup()
{
for(i=0;i<s.length-1;i++)
document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");
change(0);
}
