package com.drcl.report.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import cn.common.lib.util.json.Json2JavaUtil;
import cn.common.lib.util.web.ParamUtils;

import com.drcl.report.vo.RegTableVO;
import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 报到证打印
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2011-9-5
 */
public class RegTableAction extends ActionSupport
{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    @Override
    public String execute() throws Exception
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String printContent = ParamUtils.getParameter(request,"printcontent");

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
        RegTableVO regTableVO = Json2JavaUtil.json2Java(printContent, RegTableVO.class, new String[]{}, null);
        List<RegTableVO> datas = Lists.newArrayList();
        datas.add(regTableVO);
        request.getSession().getServletContext().setAttribute(request.getSession().getId(), regTableVO);
        request.setAttribute("datas", datas);
        return SUCCESS;
    }

}
