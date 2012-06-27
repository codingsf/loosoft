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
package cn.loosoft.stuwork.arch.web.store;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;

import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.Constant;
import cn.loosoft.stuwork.arch.entity.store.Store;
import cn.loosoft.stuwork.arch.service.store.StoreManager;

/**
 * 
 * 档案柜管理Action.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-11-29
 */
@Namespace("/store")
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "store.action", type = "redirect"),
        @Result(name = "chonghu", location = "store-input.jsp") })
public class StoreAction extends CrudActionSupport<Store>
{

    private final HttpServletRequest request          = ServletActionContext
                                                              .getRequest();

    private static final long        serialVersionUID = 1L;

    private StoreManager             storeManager;                                // 档案柜管理

    private Long                     id;                                          // 编号

    private Store                    store;                                       // 档案柜实体

    private Page<Store>              page             = new Page<Store>(
                                                              Constant.PAGE_SIZE); // 分页查询记录

    private List<Long>               ids;                                         // 批量id

    private String                   actionMessage;                               // 相同记录提示信息

    public String getActionMessage()
    {
        return actionMessage;
    }

    @Autowired
    private InstituteWebService instituteWebService; // 院系

    // 院系
    public List<InstituteDTO> getCollegues()
    {
        return instituteWebService.getInstitutes();
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return INPUT;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String list() throws Exception
    {
        if (!page.isOrderBySetted())
        {
            page.setOrder(Page.DESC);
            page.setOrderBy("id");
        }
        page = storeManager.search(page);
        // TODO Auto-generated method stub
        return SUCCESS;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#prepareModel()
     */
    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            store = storeManager.get(id);
        }
        else
        {
            store = new Store();
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.web.CrudActionSupport#save()
     */
    @Override
    public String save()
    {
        String area = request.getParameter("area");
        String rank = request.getParameter("rank");
        if (id == null)
        {
            if (storeManager.findRank(area, Integer.parseInt(rank)) == null)
            {

                if (request.getParameter("checkTrue") != null
                        && request.getParameter("checkTrue") != "")
                {

                    int rankCount = Integer.parseInt(store.getRank());
                    for (int i = 0; i < rankCount; i++)
                    {

                        int ranks = i + 1;
                        if (storeManager.findRank(area, ranks) != null)
                        {
                            continue;
                        }
                        else
                        {
                            Store storeCheck = null;
                            storeCheck = new Store();
                            storeCheck.setRank(String.valueOf(ranks));
                            storeCheck
                                    .setStorow(request.getParameter("storow"));
                            storeCheck.setStocolumn(request
                                    .getParameter("stocolumn"));
                            storeCheck.setArea(request.getParameter("area"));
                            storeManager.save(storeCheck);
                        }
                    }
                }
                else
                {
                    storeManager.save(store);
                }
                return RELOAD;
            }
            else
            {
                actionMessage = "该区域已经存在";
                return "chonghu";
            }
        }
        else
        {

            storeManager.save(store);

            return RELOAD;

        }

    }

    /**
     * 批量删除档案柜.
     */
    public String deletes()
    {
        storeManager.deletes(ids);
        return RELOAD;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see com.opensymphony.xwork2.ModelDriven#getModel()
     */
    public Store getModel()
    {
        // TODO Auto-generated method stub
        return store;
    }

    public Page<Store> getPage()
    {
        return page;
    }

    @Autowired
    public void setStoreManager(StoreManager storeManager)
    {
        this.storeManager = storeManager;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public void setIds(List<Long> ids)
    {
        this.ids = ids;
    }

}
