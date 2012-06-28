package cn.loosoft.stuwork.welnew.entity.bankRecord;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * 银行数据实体
 * 
 * @author houbing.qian
 * @version 1.0
 * @since 2010-8-25
 */
@Entity
@Table(name = "wel_bankRecord")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class BankRecord extends IdEntity
{
    private String  bankName;   // 银行名称

    private Student student;    // 学生考生号

    private Date    recordTime; // 汇款时间

    private Double  recordMoeny; // 汇款金额

    private String  recordMark; // 备注

    private boolean use;        // 是否已使用

    public String getBankName()
    {
        return bankName;
    }

    public void setBankName(String bankName)
    {
        this.bankName = bankName;
    }

    public Date getRecordTime()
    {
        return recordTime;
    }

    public void setRecordTime(Date recordTime)
    {
        this.recordTime = recordTime;
    }

    public Double getRecordMoeny()
    {
        return recordMoeny;
    }

    public void setRecordMoeny(Double recordMoeny)
    {
        this.recordMoeny = recordMoeny;
    }

    public String getRecordMark()
    {
        return recordMark;
    }

    public void setRecordMark(String recordMark)
    {
        this.recordMark = recordMark;
    }

    @Column(name = "isUse")
    public boolean isUse()
    {
        return use;
    }

    public void setUse(boolean use)
    {
        this.use = use;
    }

    @OneToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "examineeNo", referencedColumnName = "examineeNo", unique = true)
    public Student getStudent()
    {
        return student;
    }

    public void setStudent(Student student)
    {
        this.student = student;
    }

}
