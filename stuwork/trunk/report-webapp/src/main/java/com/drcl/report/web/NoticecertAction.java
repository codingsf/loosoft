package com.drcl.report.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.common.lib.util.json.Json2JavaUtil;

import com.drcl.report.vo.NoticeCertVO;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 证书打印预览
 * 
 * @author qingang
 * @version 1.0
 * @since 2011-1-17
 */
public class NoticecertAction extends ActionSupport
{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    @Override
    public String execute() throws Exception
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String printContent = request.getParameter("printcontent");

        request.setAttribute("sessionId", request.getSession().getId());

        if(printContent == null)
        {
            printContent = "";
        }
        else
        {
            printContent = java.net.URLDecoder.decode(printContent, "UTF-8");
            //printContent = new String(printContent.getBytes("iso-8859-1"), "UTF-8");
        }

        //解析内容
        List<NoticeCertVO> noticeCertvoList = Json2JavaUtil.json2JavaList(printContent, NoticeCertVO.class, new String[]{}, null);
        request.getSession().getServletContext().setAttribute(request.getSession().getId(), noticeCertvoList);
        request.setAttribute("CERT", noticeCertvoList);
        return SUCCESS;
    }

}
