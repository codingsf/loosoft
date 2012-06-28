package cn.loosoft.stuwork.workstudysite.entity.job;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.workstudysite.Constant;

/**
 * 
 * 学生岗位信息
 * 
 * @author bing.hu
 * @version 1.0
 * @since 2011-2-28
 */
@Entity
@Table(name = "stujob_student_jobs")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StudentJobs extends IdEntity
{

    private int    jobsID;            // 岗位id

    private String jobsName;          // 岗位名称

    private String collegeCode;       // 学院代码

    private int    companyID;         // 单位id

    private String studentNo;         // 学号

    private String studentName;       // 学生姓名

    private String applyReason;       // 申请原因

    private String chose;             // 是否被选择

    private Date   applyDate;         // 申请日期

    private Date   choseDate;         // 选择日期

    private String groupStatus;       // 小组审核状态

    private String centerStatus;      // 中心审核状态

    private String groupNoPassReason; // 小组审核未过原因

    private String centerNoPassReason; // 中心审核未过原因

    public int getJobsID()
    {
        return jobsID;
    }

    public void setJobsID(int jobsID)
    {
        this.jobsID = jobsID;
    }

    public String getJobsName()
    {
        return jobsName;
    }

    public void setJobsName(String jobsName)
    {
        this.jobsName = jobsName;
    }

    public int getCompanyID()
    {
        return companyID;
    }

    public void setCompanyID(int companyID)
    {
        this.companyID = companyID;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getStudentName()
    {
        return studentName;
    }

    public void setStudentName(String studentName)
    {
        this.studentName = studentName;
    }

    public String getApplyReason()
    {
        return applyReason;
    }

    public void setApplyReason(String applyReason)
    {
        this.applyReason = applyReason;
    }

    public String getChose()
    {
        return chose;
    }

    public void setChose(String chose)
    {
        this.chose = chose;
    }

    public Date getApplyDate()
    {
        return applyDate;
    }

    public void setApplyDate(Date applyDate)
    {
        this.applyDate = applyDate;
    }

    public Date getChoseDate()
    {
        return choseDate;
    }

    public void setChoseDate(Date choseDate)
    {
        this.choseDate = choseDate;
    }

    public String getGroupStatus()
    {
        return groupStatus;
    }

    public void setGroupStatus(String groupStatus)
    {
        this.groupStatus = groupStatus;
    }

    public String getCenterStatus()
    {
        return centerStatus;
    }

    public void setCenterStatus(String centerStatus)
    {
        this.centerStatus = centerStatus;
    }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public String getGroupNoPassReason()
    {
        return groupNoPassReason;
    }

    public void setGroupNoPassReason(String groupNoPassReason)
    {
        this.groupNoPassReason = groupNoPassReason;
    }

    public String getCenterNoPassReason()
    {
        return centerNoPassReason;
    }

    public void setCenterNoPassReason(String centerNoPassReason)
    {
        this.centerNoPassReason = centerNoPassReason;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    @Transient
    public String getGroupStatusDesc()
    {
        if (this.groupStatus.equals(Constant.SHZ))
        {
            return "审核中";
        }
        if (this.groupStatus.equals(Constant.SHTG))
        {
            return "审核通过";
        }
        if (this.groupStatus.equals(Constant.SHWTG))
        {
            return "审核未通过";
        }
        return "";
    }

    @Transient
    public String getChoseDesc()
    {
        if (this.chose.equals(Constant.CHOSING))
        {
            return "选择中";
        }
        if (this.chose.equals(Constant.APPLY))
        {
            return "选择通过";
        }
        if (this.chose.equals(Constant.PASS))
        {
            return "选择未通过";
        }
        return "";
    }

    @Transient
    public String getCenterStatusDesc()
    {
        if (this.centerStatus.equals(Constant.SHZ))
        {
            return "审核中";
        }
        if (this.centerStatus.equals(Constant.SHTG))
        {
            return "审核通过";
        }
        if (this.centerStatus.equals(Constant.SHWTG))
        {
            return "审核未通过";
        }
        return "";
    }

}
