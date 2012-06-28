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
package cn.loosoft.stuwork.welnew.web.count;

import java.util.List;

import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.json.Json2JavaUtil;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.StudentReportVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 统计新生报到Action.
 * 
 * @author fangyong
 * @version 1.0
 * @since 2011-3-25
 */
@Namespace("/count")
public class StudentreportAction extends ActionSupport
{

    /**
     * serialVersionUID long
     */
    private static final long     serialVersionUID = 1L;

    private StudentManager        studentManager;

    private WelbatchManager       welbatchManager;

    private long                  countAllReport;                         // 当前批次下的全校应入学人数

    private String                noReport;                               // 当前批次下的全校未入学人数

    private long                  alreadyAllReport;                       // 当前批次下的全校已入学人数

    private List<StudentReportVO> reportVOs        = Lists.newArrayList(); // 新生入学报到学院统计

    /**
     * 统计新生入学报到人数
     * 
     * @since 2011-9-1
     * @see cn.loosoft.springside.web.CrudActionSupport#list()
     */
    @Override
    public String execute() throws Exception
    {
        // 获得当前批次
        Welbatch curWelbatch = welbatchManager.getCurrentBatch();

        // 获得当前批次下的未报到人数
        // noReport = studentManager.countStudent(curWelbatch, false);

        // 获得当前批次下的已报到人数
        alreadyAllReport = studentManager.countStudent(curWelbatch, true);

        // 获得当前批次下的应报到人数
        countAllReport = studentManager.countStudent(null, curWelbatch);

        // 报到率
        if (countAllReport > 0)
        {
            noReport = Math
                    .round((alreadyAllReport / (countAllReport * 1.0F)) * 1000)
                    / 10.0 + "%";
        }

        // 获得当前批次下新生入学报到学院统计
        reportVOs = studentManager.getGroupStudentsByUnit(curWelbatch);

        return SUCCESS;
    }

    public String print() throws Exception
    {
        try
        {
            // 获得当前批次
            Welbatch curWelbatch = welbatchManager.getCurrentBatch();

            // 获得当前批次下的未报到人数
            // noReport = studentManager.countStudent(curWelbatch, false);

            // 获得当前批次下的已报到人数
            alreadyAllReport = studentManager.countStudent(curWelbatch, true);

            // 获得当前批次下的应报到人数
            countAllReport = studentManager.countStudent(null, curWelbatch);

            // 报到率
            if (countAllReport > 0)
            {
                noReport = Math
                        .round((alreadyAllReport / (countAllReport * 1.0F)) * 1000)
                        / 10.0 + "%";
            }

            // 获得当前批次下各学院人数的报到情况
            reportVOs = studentManager.getGroupStudentsByUnit(curWelbatch);
            StudentReportVO s = new StudentReportVO();
            s.setUnitName("总计:");
            s.setMustReportCount(countAllReport);
            s.setAlreadyReportCount(alreadyAllReport);
            s.setNoReportCount(noReport);
            reportVOs.add(s);
            String json = Json2JavaUtil.JavaList2Json(reportVOs);
            // 重定向到打印服务
            // TODO Auto-generated method stub
            Struts2Utils.getRequest().setAttribute("printcontent",
                    java.net.URLEncoder.encode(json, "UTF-8"));
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "print";
    }

    // 当前批次下的全校应入学人数
    public long getCountAllReport()
    {
        return countAllReport;
    }

    // 当前批次下的全校未入学人数
    public String getNoReport()
    {
        return noReport;
    }

    // 当前批次下的全校已入学人数
    public long getAlreadyAllReport()
    {
        return alreadyAllReport;
    }

    // 新生入学报到学院统计
    public List<StudentReportVO> getReportVOs()
    {
        return reportVOs;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }
}
