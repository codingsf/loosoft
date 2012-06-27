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
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import cn.common.lib.util.json.Json2JavaUtil;
import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.stuwork.arch.entity.store.Store;
import cn.loosoft.stuwork.arch.service.store.StoreManager;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 处理档案柜级联请求的action
 * 
 * @author chengpeng.zhang
 * @version 1.0
 * @since 2010-8-29
 * @author jie.yang
 * @version 1.1
 */
@ParentPackage("json-default")
@Namespace("/store")
@Results( { @Result(type = "json") })
public class StorechangeAction extends ActionSupport
{
    @Autowired
    private StoreManager storeManager; // 库位管理

    private String       rank;

    private String       row;

    private String       column;

    /**
     * 排
     * 
     * @since 2010-12-20
     * @author yangjie
     * @return
     */
    public String rankList()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String area = ParamUtils.getParameter(request, "areaValue", "");
        List<Store> areaList = storeManager.getAll(area, 0, 0);
        rank = Json2JavaUtil.JavaList2Json(areaList);
        return SUCCESS;
    }

    /**
     * 行
     * 
     * @since 2010-12-20
     * @author yangjie
     * @return
     */
    public String rowList()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String area = ParamUtils.getParameter(request, "areaValue", "");
        String rank = ParamUtils.getParameter(request, "rankValue", "");
        List<Store> rowcolumnList = storeManager.getAll(area, Integer
                .parseInt(rank), 0);
        row = Json2JavaUtil.JavaList2Json(rowcolumnList);
        return SUCCESS;
    }

    /**
     * 列
     * 
     * @since 2010-12-20
     * @author yangjie
     * @return
     */
    public String columnList()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String area = ParamUtils.getParameter(request, "areaValue", "");
        String rank = ParamUtils.getParameter(request, "rankValue", "");
        int row = Integer.parseInt(ParamUtils.getParameter(request, "rowValue",
                ""));
        List<Store> rowcolumnList = storeManager.getAll(area, Integer
                .parseInt(rank), row);
        column = Json2JavaUtil.JavaList2Json(rowcolumnList);
        return SUCCESS;
    }

    @JSON(name = "rank")
    public String getRank()
    {
        return this.rank;
    }

    @JSON(name = "row")
    public String getRow()
    {
        return this.row;

    }

    @JSON(name = "column")
    public String getColumn()
    {
        return this.column;

    }
}
