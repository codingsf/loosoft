using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.IO;
using sungrow_demo.Service;

namespace sungrow_demo
{
    class HttpServer
    {
        bool isStop = false;
        public HttpServer()
        {
        }

        public void stop() {
            this.isStop = true;
        }

        public void start()
        {
            try
            {
                LogUtil.debug("start http server");
                using (HttpListener listerner = new HttpListener())
                {
                    listerner.AuthenticationSchemes = AuthenticationSchemes.Anonymous;//指定身份验证  Anonymous匿名访问18.                
                    listerner.Prefixes.Add("http://localhost:8111/web/");
                    if(listerner.IsListening)
                        listerner.Stop();
                    listerner.Start();

                    Console.WriteLine("WebServer Start Successed.......");
                    while (!isStop)
                    {
                        //等待请求连接26.                    
                        //没有请求则GetContext处于阻塞状态27.                   
                        HttpListenerContext ctx = listerner.GetContext();
                        ctx.Response.StatusCode = 200;//设置返回给客服端http状态代码29.                   
                        string plantId = ctx.Request.QueryString["plantId"];
                        string plantName = ctx.Request.QueryString["plantName"];
                        if (plantId != null)
                        {
                            LogUtil.debug("http server accept plantId:" + plantId);
                        }

                        //使用Writer输出http响应代码38.                   
                        using (StreamWriter writer = new StreamWriter(ctx.Response.OutputStream))
                        {
                            Console.WriteLine("hello");
                            writer.WriteLine("<html><head><title>The WebServer Test</title></head><body>");
                            writer.WriteLine("<div style=\"height:20px;color:blue;text-align:center;\"><p> hello {0}</p></div>", plantId);
                            writer.WriteLine("<ul>");


                            foreach (string header in ctx.Request.Headers.Keys)
                            {
                                writer.WriteLine("<li><b>{0}:</b>{1}</li>", header, ctx.Request.Headers[header]);

                            }
                            writer.WriteLine("</ul>");
                            writer.WriteLine("</body></html>");


                            writer.Close();
                            ctx.Response.Close();
                        }

                        ControlCenter.pauseTime = DateTime.Now;
                        ControlCenter.isPause = true;
                        LogUtil.debug("manualopen plant:" + plantId);
                        AcceptForm.sendCmdMessage("manualopen-" + plantId);//打开详细页面
                    }
                }
            }
            catch (Exception ee) {
                LogUtil.error("start http server error:" + ee.StackTrace);
            }
        }
    }
}
