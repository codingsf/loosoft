//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.backmanage.web.account;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.service.ServiceException;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.account.UserType;
import cn.loosoft.stuwork.backmanage.service.account.UserTypeManager;

/**
 * 用户类型管理Action.
 * 
 * 
 * @author shanru.wu
 */
// 定义URL映射对应/account/user!input.action
@Namespace("/account")
// 定义名为reload的result重定向到user.action, 其他result则按照convention默认.
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "user-type.action", type = "redirect") })
public class UserTypeAction extends CrudActionSupport<UserType>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    UserTypeManager           userTypeManager;

    // -- 页面属性 --//
    private Long              id;

    private Page<UserType>    page             = new Page<UserType>(20);

    private UserType          entity;

    // -- ModelDriven 与 Preparable函数 --//

    public void setId(Long id)
    {
        this.id = id;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (null != id)
        {
            entity = userTypeManager.get(id);
        }
        else
        {
            entity = new UserType();
        }

    }

    public UserType getModel()
    {
        return entity;
    }

    // -- CRUD Action 函数 --//

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.ASC);
            page.setOrderBy("id");

        }
        page = userTypeManager.search(page);
        return SUCCESS;
    }

    @Override
    public String save() throws Exception
    {
        userTypeManager.save(entity);
        addActionMessage("保存用户类型成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        try
        {
            userTypeManager.delete(id);
            addActionMessage("删除用户类型成功");
        }
        catch (ServiceException e)
        {
            logger.error(e.getMessage(), e);
            addActionMessage("删除用户类型失败,原因：" + e.getMessage());
        }
        return RELOAD;
    }

    // -- 其他Action函数 --//

    /**
     * 支持使用Jquery.validate Ajax检验用户名是否重复.
     * 
     * @throws UnsupportedEncodingException
     */
    public String checkUserType() throws UnsupportedEncodingException
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        request.setCharacterEncoding("UTF-8");
        String newType = request.getParameter("type");
        newType = new String(newType.getBytes("ISO-8859-1"), "UTF-8");
        String oldType = request.getParameter("oldType");

        if (userTypeManager.isTypeUnique(newType, oldType))
        {
            Struts2Utils.renderText("true");
        }
        else
        {
            Struts2Utils.renderText("false");
        }
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    // -- 页面属性访问函数 --//
    public Page<UserType> getPage()
    {
        return page;
    }

    @Autowired
    public void setUserTypeManager(UserTypeManager userTypeManager)
    {
        this.userTypeManager = userTypeManager;
    }

}
