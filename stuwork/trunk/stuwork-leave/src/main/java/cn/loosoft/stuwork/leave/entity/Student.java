package cn.loosoft.stuwork.leave.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

import com.google.common.collect.Lists;

/**
 * 
 * 离校学生基础表
 * 
 * @author chenbo
 * @version 1.0
 * @since 2012-06-09
 */
@Entity
@Table(name = "student")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Student extends IdEntity {

	private String studentno;// 学号

	private String fullname;// 姓名

	private String sex;// 性别

	private String collegecode;// 学院代码

	private String collegename;// 学院

	private String majorcode;// 专业代码

	private String majorname;// 专业

	private String classcode;// 班级代码

	private String classname;// 班级名称

	private String comname;// 批次

	private List<StudentCheck> studentChecks = Lists.newArrayList(); // 有序的关联对象集合

	@OneToMany(targetEntity = StudentCheck.class, cascade=CascadeType.PERSIST)
    @JoinColumn(name = "studentid")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
	public List<StudentCheck> getStudentChecks() {
		return studentChecks;
	}

	public void setStudentChecks(List<StudentCheck> studentChecks) {
		this.studentChecks = studentChecks;
	}

	public String getComname() {
		return comname;
	}

	public void setComname(String comname) {
		this.comname = comname;
	}

	public String getCollegecode() {
		return collegecode;
	}

	public void setCollegecode(String collegecode) {
		this.collegecode = collegecode;
	}

	public String getMajorcode() {
		return majorcode;
	}

	public void setMajorcode(String majorcode) {
		this.majorcode = majorcode;
	}

	public String getClasscode() {
		return classcode;
	}

	public void setClasscode(String classcode) {
		this.classcode = classcode;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getCollegename() {
		return collegename;
	}

	public void setCollegename(String collegename) {
		this.collegename = collegename;
	}

	public String getMajorname() {
		return majorname;
	}

	public void setMajorname(String majorname) {
		this.majorname = majorname;
	}

	public String getStudentno() {
		return studentno;
	}

	public void setStudentno(String studentno) {
		this.studentno = studentno;
	}

}
