//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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
package cn.loosoft.stuwork.welnew.vo;

import java.util.Date;


/**
 * 寝室VO
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-24
 */

public class MajorClazzVO
{
    private long infoId;//  专业班级信息id
    private String  welbatch;          //入学批次

    private String   collegeDepartName;      //所在学院名称

    private String   majorName;        //专业名

    private boolean assigned;          //是否分班

    private Date assignDate;           //分班日期 

    private String clazzs;             //班级串，逗号分隔

    private int clazzNums;                  //班级数量

    private int studentNums;                //学生数量

    private String typedesc;          //专业学生类别

    public String getWelbatch()
    {
        return welbatch;
    }

    public void setWelbatch(String welbatch)
    {
        this.welbatch = welbatch;
    }

    public String getMajorName()
    {
        return majorName;
    }

    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getCollegeDepartName()
    {
        return collegeDepartName;
    }

    public void setCollegeDepartName(String collegeDepartName)
    {
        this.collegeDepartName = collegeDepartName;
    }

    public boolean isAssigned()
    {
        return assigned;
    }

    public void setAssigned(boolean assigned)
    {
        this.assigned = assigned;
    }

    public Date getAssignDate()
    {
        return assignDate;
    }

    public void setAssignDate(Date assignDate)
    {
        this.assignDate = assignDate;
    }

    public String getClazzs()
    {
        return clazzs;
    }

    public void setClazzs(String clazzs)
    {
        this.clazzs = clazzs;
    }


    public int getClazzNums()
    {
        return clazzNums;
    }

    public void setClazzNums(int clazzNums)
    {
        this.clazzNums = clazzNums;
    }

    public int getStudentNums()
    {
        return studentNums;
    }

    public void setStudentNums(int studentNums)
    {
        this.studentNums = studentNums;
    }

    public long getInfoId()
    {
        return infoId;
    }

    public void setInfoId(long infoId)
    {
        this.infoId = infoId;
    }

    public String getTypedesc()
    {
        return typedesc;
    }

    public void setTypedesc(String typedesc)
    {
        this.typedesc = typedesc;
    }


}
