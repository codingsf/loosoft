package cn.loosoft.stuwork.leave.entity;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 离校学生審核表
 * 
 * @author chenbo
 * @version 1.0
 * @since 2012-06-09
 */
@Entity
@Table(name = "studentcheck")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class StudentCheck extends IdEntity {
	private String departmentcode;// 审批部门code
	private String checkdate;// 审批时间
	private int status;// 审批状态

	private Student student;// 所属的学生对象
	
	@ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
	@NotFound(action = NotFoundAction.IGNORE)
	@JoinColumn(name = "studentid")
	public Student getStudent() {
		return student;
	}
	
	public void setStudent(Student student) {
		this.student = student;
	}

	/**
	 * 
	 * enable 已经审批
	 */
	public static final int STATUS_ENABLE = 1;
	/**
	 * disable 禁止审批
	 */
	public static final int STATUS_DISABLE = 2;

	/**
	 * disable 未审批 初始状态
	 */
	public static final int STATUS_NORMAL = 0;

	public String getDepartmentcode() {
		return departmentcode;
	}

	public void setDepartmentcode(String departmentcode) {
		this.departmentcode = departmentcode;
	}

	public String getCheckdate() {
		return checkdate;
	}

	public void setCheckdate(String checkdate) {
		this.checkdate = checkdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
