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
package cn.loosoft.stuwork.arch.web.sys;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;

/**
 * 
 * 入库材料管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-17
 */
@Namespace("/sys")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "stuff.action", type = "redirect") })
public class StuffAction extends DictionaryAction
{
    private static final long serialVersionUID = 1L;

    // --CRUD Action 函数-- //

    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("value");
            page.setOrder(Page.ASC);
        }
        page = dictionaryManager.search(page, Dictionary.RKCL);
        return SUCCESS;
    }

    @Override
    public String save() throws Exception
    {
        if (!dictionaryManager.isPropertyUnique(entity.getValue(),
                Dictionary.RKCL)) // 判断值是否唯一
        {
            if (id == null)
            {
                addActionMessage("操作失败，检查是否已存在");
            }
            else
            {
                addActionMessage("保存入库材料成功");
            }
            return RELOAD;
        }
        else
        {
            entity.setType(Dictionary.RKCL);
            dictionaryManager.save(entity);
            addActionMessage("保存入库材料成功");
            return RELOAD;
        }
    }

    @Override
    public String delete() throws Exception
    {
        dictionaryManager.delete(id);
        Struts2Utils.renderText("删除入库材料成功");
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;

    }

    /**
     * 
     * 批量删除系统字典信息.
     * 
     * @since 2010-12-17
     * @author shanru.wu
     * @return
     * @throws Exception
     */
    @Override
    public String deletes() throws Exception
    {
        if (null != this.ids && this.ids.size() > 0)
        {
            dictionaryManager.deletes(ids);
            addActionMessage("批量删除入库材料成功");
        }
        else
        {
            addActionMessage("没有可删除记录，请勾选");
        }
        return RELOAD;
    }
}
