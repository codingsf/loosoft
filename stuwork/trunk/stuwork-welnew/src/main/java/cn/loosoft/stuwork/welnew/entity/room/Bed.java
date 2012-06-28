package cn.loosoft.stuwork.welnew.entity.room;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.entity.IdEntity;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.student.Student;

/**
 * 
 * 公寓床位信息
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-24
 */
@Entity
@Table(name = "wel_bed")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Bed extends IdEntity {

    private String   collegeCode;      //录取学院代码

    private String   collegeName;      //所在学院名称

    private String   departCode;       //录取系代码

    private String   departName;       //所在系名称

    private String   majorCode;        //录取专业代码

    private String   majorName;        //专业名称

    private String   className;        //班级名称

    private String   classCode;        //班级

    private String   building;         //楼

    private String   floor;            //楼层

    private String   room;             //宿舍、房间

    private String   bedNo;            //床位号
    
    private boolean assigned;          //是否已分配
    
	private Student student;           //分配给的新生

    private String  sex;               //性别

	private Welbatch welbatch;         //所在批次

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getCollegeName()
    {
        return collegeName;
    }

    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }

    public String getDepartCode()
    {
        return departCode;
    }

    public void setDepartCode(String departCode)
    {
        this.departCode = departCode;
    }

    public String getDepartName()
    {
        return departName;
    }

    public void setDepartName(String departName)
    {
        this.departName = departName;
    }
    
    public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getMajorName()
    {
        return majorName;
    }

    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public String getBuilding()
    {
        return building;
    }

    public void setBuilding(String building)
    {
        this.building = building;
    }

    public String getFloor()
    {
        return floor;
    }

    public void setFloor(String floor)
    {
        this.floor = floor;
    }

    public String getRoom()
    {
        return room;
    }

    public void setRoom(String room)
    {
        this.room = room;
    }

    public String getBedNo()
    {
        return bedNo;
    }

    public void setBedNo(String bedNo)
    {
        this.bedNo = bedNo;
    }
    
    @Column(name="isAssigned")
	public boolean isAssigned() {
		return assigned;
	}

	public void setAssigned(boolean assigned) {
		this.assigned = assigned;
	}

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "welbatchID")
    public Welbatch getWelbatch()
    {
        return welbatch;
    }

    public void setWelbatch(Welbatch welbatch)
    {
        this.welbatch = welbatch;
    }

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @NotFound(action = NotFoundAction.IGNORE)
    @JoinColumn(name = "studentID")
    public Student getStudent()
    {
        return student;
    }

    public void setStudent(Student student)
    {
        this.student = student;
    }

    @Transient
    public String getSexdesc(){
        return this.sex.equals("m")?"男":"女";
    }
    /**
     * 
     * 组合院系的名称
     * @since  2010-8-22
     * @author houbing.qian
     * @return
     */
    @Transient
    public String getColdepartdesc(){
        return this.getCollegeName()==null?"":this.getCollegeName()+this.getDepartName()==null?"":this.getDepartName();
    }
    @Transient
    public String getStudentName(){
        return student ==null?"":student.getName();
    }
}
