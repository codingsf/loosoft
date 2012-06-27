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

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;
import cn.loosoft.stuwork.arch.service.sys.DictionaryManager;

/**
 * 
 * 系统字典管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2010-12-17
 */
public class DictionaryAction extends CrudActionSupport<Dictionary>
{

    private static final long   serialVersionUID = 1L;

    HttpServletRequest          request          = Struts2Utils.getRequest();

    // --页面属性-- /
    protected Long              id;

    protected List<Long>        ids;

    protected Dictionary        entity;

    protected DictionaryManager dictionaryManager;                           // 系统字典信息

    protected Page<Dictionary>  page             = new Page<Dictionary>(5);  // 分页列表显示入库材料

    // -- ModelDriven 与 Preparable函数 --//

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = dictionaryManager.get(id);
        }
        else
        {
            entity = new Dictionary();
        }

    }

    public Dictionary getModel()
    {
        return entity;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    // --CRUD Action 函数-- //

    @Override
    public String input() throws Exception
    {
        return INPUT;
    }

    @Override
    public String list() throws Exception
    {
        dictionaryManager.save(entity);

        return SUCCESS;
    }

    @Override
    public String save() throws Exception
    {

        return null;
    }

    @Override
    public String delete() throws Exception
    {
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
    public String deletes() throws Exception
    {
        dictionaryManager.deletes(ids);
        addActionMessage("批量删除成功");
        return RELOAD;
    }

    // --页面访问函数-- //

    public Dictionary getEntity()
    {
        return entity;
    }

    public Page<Dictionary> getPage()
    {
        return page;
    }

    // -- 其他Action函数 -- /
    @Autowired
    public void setDictionaryManager(DictionaryManager dictionaryManager)
    {
        this.dictionaryManager = dictionaryManager;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

}
