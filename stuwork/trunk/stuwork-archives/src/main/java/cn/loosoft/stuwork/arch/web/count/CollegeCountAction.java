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
package cn.loosoft.stuwork.arch.web.count;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.arch.service.archives.ArchivesManager;
import cn.loosoft.stuwork.arch.util.BaseExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelDownLoad;
import cn.loosoft.stuwork.arch.util.ExcelModel;
import cn.loosoft.stuwork.arch.vo.CountVO;

/**
 * 
 * 按院系统计管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-1
 */
@Namespace("/count")
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "college-count.action", type = "redirect") })
public class CollegeCountAction extends CrudActionSupport<Object>
{

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    ArchivesManager           archivesManager;

    private List<CountVO>     collegeVOs;

    // ==CRUD Action 函数== //
    @Override
    public String input() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public String list() throws Exception
    {
        this.collegeVOs = archivesManager.collegeCount();
        return SUCCESS;
    }

    /**
     * 
     * 导出excel
     * 
     * @since 2011-1-8
     * @author Administrator
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String printExcel() throws Exception
    {

        HttpServletResponse response = Struts2Utils.getResponse();

        this.collegeVOs = archivesManager.collegeCount();
        ExcelModel excel = new ExcelModel();
        ArrayList header = new ArrayList();
        String titleStr = "学院;状态;人数;学院总人数";// 标题
        String[] titles = titleStr.split(";");
        for (String title : titles)
        {
            header.add(title);
        }

        ArrayList data = new ArrayList();

        if (null != collegeVOs && collegeVOs.size() > 0)
        {
            for (CountVO countVO : collegeVOs)
            {

                ArrayList rowData = new ArrayList();
                rowData.add(countVO.getCollegeName());
                rowData.add(countVO.getStatus());
                rowData.add(countVO.getAmount());
                rowData.add(countVO.getTotal());
                data.add(rowData);

            }
            // 设置报表标题
            excel.setHeader(header);
            // 报表名称
            excel.setSheetName("档案统计-按学院统计");
            // 设置报表内容
            excel.setData(data);
            // 写入到Excel格式输出流供下载
            try
            {

                // 调用自编的下载类，实现Excel文件的下载
                ExcelDownLoad downLoad = new BaseExcelDownLoad();

                // 不生成文件，直接生成文件输出流供下载
                downLoad.downLoad("档案统计-按学院统计.xls", excel, response);

            }
            catch (Exception e)
            {

                e.printStackTrace();

            }
        }

        return null;

    }

    @Override
    protected void prepareModel() throws Exception
    {
        // TODO Auto-generated method stub

    }

    @Override
    public String save() throws Exception
    {
        // TODO Auto-generated method stub
        return null;
    }

    public Object getModel()
    {
        // TODO Auto-generated method stub
        return null;
    }

    public List<CountVO> getCollegeVOs()
    {
        return collegeVOs;
    }

    @Autowired
    public void setArchivesManager(ArchivesManager archivesManager)
    {
        this.archivesManager = archivesManager;
    }

}
