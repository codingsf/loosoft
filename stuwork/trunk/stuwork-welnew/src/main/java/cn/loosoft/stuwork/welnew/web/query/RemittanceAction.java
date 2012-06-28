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
package cn.loosoft.stuwork.welnew.web.query;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.welnew.Constant;
import cn.loosoft.stuwork.welnew.entity.bankRecord.BankRecord;
import cn.loosoft.stuwork.welnew.service.bankRecord.BankRecordManager;
import cn.loosoft.stuwork.welnew.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelDownLoad;
import cn.loosoft.stuwork.welnew.util.ExcelModel;

/**
 * 
 * 银行汇款查询Action.
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-3-25
 */
@Namespace("/query")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "remittance.action", type = "redirect") })
public class RemittanceAction extends CrudActionSupport<BankRecord>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    private BankRecordManager bankRecordManager;

    // -- 页面属性 --//
    private Long              id;

    private BankRecord        entity;

    private Page<BankRecord>  page             = new Page<BankRecord>(
                                                       Constant.PAGE_SIZE);

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public BankRecord getEntity()
    {
        return entity;
    }

    public void setEntity(BankRecord entity)
    {
        this.entity = entity;
    }

    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        // TODO Auto-generated method stub

        page = bankRecordManager.search(page);
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub
        if (id != null)
        {
            entity = bankRecordManager.get(id);
        }
        else
        {
            entity = new BankRecord();
        }
    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    /**
     * * 导出excel
     * 
     * @since 2011-3-28
     * @author bing.hu
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {
        System.out.println(1111);
        List<BankRecord> banklist = bankRecordManager.getAll();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "汇款人;汇款银行;汇款时间;汇款金额;使用者;备注"; // 标题名称
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }
        ArrayList list = new ArrayList();

        if (banklist != null && banklist.size() > 0)
        {

            for (BankRecord bank : banklist)
            {
                ArrayList rowlist = new ArrayList();
                rowlist.add(bank.getStudent().getName());
                rowlist.add(bank.getBankName());
                rowlist.add(bank.getRecordTime());
                rowlist.add(bank.getRecordMoeny());
                rowlist.add(bank.getStudent().getName());
                rowlist.add(bank.getRecordMark());
                list.add(rowlist);
            }
        }

        // 设置报表标题
        excel.setHeader(header);

        // 报表名称
        excel.setSheetName("银行汇款信息");

        // 设置报表内容
        excel.setData(list);

        // 写入到Excel格式输出流供下载
        try
        {

            // 调用自编的下载类，实现Excel文件的下载
            ExcelDownLoad downLoad = new BaseExcelDownLoad();

            // 不生成文件，直接生成文件输出流供下载
            downLoad.downLoad("银行汇款信息.xls", excel, Struts2Utils.getResponse());

        }
        catch (Exception e)
        {

            e.printStackTrace();
        }

        return null;
    }

    public BankRecord getModel()
    {
        // TODO Auto-generated method stub
        return entity;
    }

    @Autowired
    public void setBankRecordManager(BankRecordManager bankRecordManager)
    {
        this.bankRecordManager = bankRecordManager;
    }

    public Page<BankRecord> getPage()
    {
        return page;
    }

}
