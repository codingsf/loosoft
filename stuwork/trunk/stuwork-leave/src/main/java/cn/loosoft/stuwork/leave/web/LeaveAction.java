package cn.loosoft.stuwork.leave.web;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.PropertyUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.common.util.web.ParamUtils;
import cn.loosoft.data.webservice.api.batch.BatchWebService;
import cn.loosoft.data.webservice.api.batch.dto.BatchDTO;
import cn.loosoft.data.webservice.api.school.ClazzWebService;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.SpecialtyWebService;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.data.webservice.api.school.dto.SpecialtyDTO;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.data.webservice.api.user.UserWebService;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.stuwork.leave.entity.Student;
import cn.loosoft.stuwork.leave.entity.StudentCheck;
import cn.loosoft.stuwork.leave.service.StudentCheckService;
import cn.loosoft.stuwork.leave.service.StudentService;
import cn.loosoft.stuwork.leave.util.Pages;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 批次管理Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-7
 */
@SuppressWarnings("serial")
@Namespace("/leave")
@Results( { @Result(name = "stuinit", location = "stuinit.jsp"),
		@Result(name = "check", location = "leave-check.jsp"),
		@Result(name = "list", location = "leave-list.jsp") })
public class LeaveAction extends ActionSupport {

	private final Pages curpage = new Pages();
	private Page<Student> page = new Page<Student>(20);
	private List<InstituteDTO> colleges; // 学院/部门
	private List<SpecialtyDTO> majors; // 专业
	private List<ClazzDTO> clazzes; // 班级
	private List<BatchDTO> batches; // 批次
	private List<Student> students;// 审核学生列表
	private final HttpServletRequest request = Struts2Utils.getRequest();
	@Autowired
	private InstituteWebService instituteWebService;
	@Autowired
	private StudentWebService studentWebService;
	@Autowired
	private SpecialtyWebService specialtyWebService;
	@Autowired
	private BatchWebService batchWebService;
	@Autowired
	private StudentService studentService;
	@Autowired
	private StudentCheckService studentCheckService;
	@Autowired
	private ClazzWebService clazzWebService;
	@Autowired
	private UserWebService userWebService;

	private String departmentids;

	private Boolean ischeck;

	public Boolean getIscheck() {
		return ischeck;
	}

	public void setIscheck(Boolean ischeck) {
		this.ischeck = ischeck;
	}

	public String getDepartmentids() {
		return departmentids;
	}

	public void setDepartmentids(String departmentids) {
		this.departmentids = departmentids;
	}

	private List<InstituteDTO> instituteDTOs;// 部门列表

	// -- CRUD Action 函数 --//
	/**
	 * 初始化参与本次审批的部门,用户在本系统内显示
	 * 
	 * @author bochins
	 * @since 2012-6-9
	 * 
	 */
	public String init() throws Exception {
		instituteDTOs = instituteWebService.getInstitutes();
		String dfile = PropertyUtils.getProperty("departmentfile.path",
				"E:\\java\\department.txt");
		File file = new File(dfile);
		departmentids = org.apache.commons.io.FileUtils.readFileToString(file);
		return SUCCESS;
	}

	// -- CRUD Action 函数 --//
	/**
	 * 初始化学生
	 * 
	 * @author bochins
	 * @since 2012-6-9
	 * 
	 */
	public String stuinit() throws Exception {
		return "stuinit";
	}

	// -- CRUD Action 函数 --//
	/**
	 * 初始化学生操作
	 * 
	 * @author bochins
	 * @since 2012-6-9
	 * 
	 */
	public String stuinitsave() throws Exception {
		
		studentService.DeleteAll();
		// 取得哪些部门需要参入审核
		String dfile = PropertyUtils.getProperty("departmentfile.path",
				"E:\\java\\department.txt");
		File file = new File(dfile);
		departmentids = org.apache.commons.io.FileUtils.readFileToString(file);

		String[] strs = departmentids.split(",");
		int pi = 1;
		curpage.setPageSize(1000);
		curpage.setTotalCount(Integer.parseInt(String.valueOf(studentWebService
				.countStudent(null, null, null, null, null, null, null, null,
						null, null))));
		for (; pi <= curpage.getTotalPages(); pi++) {
			curpage.setPageNo(pi);
			List<StudentDTO> studentDTOs = studentWebService
					.getStudentsByStudentNos(getStuNos());

			for (StudentDTO dto : studentDTOs) {
				Student student = new Student();
				student.setStudentno(dto.getStudentNo());
				student.setCollegecode(dto.getCollegeCode());
				student.setCollegename(dto.getCollegeName());
				student.setMajorcode(dto.getMajorCode());
				student.setMajorname(dto.getMajorName());
				student.setSex(dto.getSexDesc());
				student.setFullname(dto.getName());
				student.setClasscode(dto.getClassCode());
				student.setClassname(dto.getClassName());
				student.setComname(dto.getComname());
				List<StudentCheck> studentChecks = Lists.newArrayList();
				for (String s : strs) {
					StudentCheck studentCheck = new StudentCheck();
					studentCheck.setCheckdate("");
					studentCheck.setDepartmentcode(s.trim());
					studentCheck.setStatus(StudentCheck.STATUS_NORMAL);
					studentChecks.add(studentCheck);
				}
				student.setStudentChecks(studentChecks);
				studentService.save(student);
			}
		}
		addActionMessage("初始化学生信息成功");
		return "stuinit";
	}

	/**
	 * 学号列表
	 * 
	 * @since 2010-12-24
	 * @author shanru.wu
	 * @return
	 * @return
	 */
	public List<String> getStuNos() {
		List<String> stuNos = studentWebService.getStudentNosByCondition(null,
				null, null, null, null, null, null, null, null, null, curpage
						.getPageNo(), curpage.getPageSize());

		return stuNos;
	}

	// -- CRUD Action 函数 --//
	/**
	 * 保存部门配置信息
	 * 
	 * @author bochins
	 * @since 2012-6-9
	 * 
	 */
	public String save() throws Exception {
		instituteDTOs = instituteWebService.getInstitutes();
		String dfile = PropertyUtils.getProperty("departmentfile.path",
				"E:\\java\\department.txt");
		File file = new File(dfile);
		org.apache.commons.io.FileUtils.writeStringToFile(file, departmentids,
				"utf-8");
		addActionMessage("初始化部门成功");
		return SUCCESS;
	}

	/**
	 * 保存部门配置信息
	 * 
	 * @author bochins
	 * @since 2012-6-9
	 * 
	 */
	public String list() throws Exception {

		User user = (User) SpringSecurityUtils.getCurrentUser();
		UserDTO userDTO = userWebService.getUser(user.getUsername());
		String departmentcode = userDTO.getCollegeCode();
		// 判断当前用户的code 是部门 还是学院 如果是部门类型可以查询所有的，如果是学院类型只能是当前学院下的学生
		String collegeCode = request.getParameter("filter_EQS_collegeCode");
		String majorCode = request.getParameter("filter_EQS_majorCode");
		String classzz = request.getParameter("filter_EQS_classCode");
		page = studentService.search(page, collegeCode, majorCode, classzz,
				null, ischeck);
		return "list";
	}

	/**
	 * 审核学生
	 * 
	 * @author bochins
	 * @since 2012-6-13
	 * 
	 */
	public String check() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String studentId = ParamUtils.getParameter(request, "sid", "");// 获取studentid

		User user = (User) SpringSecurityUtils.getCurrentUser();
		UserDTO userDTO = userWebService.getUser(user.getUsername());
		String departmentcode = userDTO.getCollegeCode();
		// 获取当前用户所在的部门

		StudentCheck studentCheck = studentCheckService.get(studentId,
				departmentcode);
		if (studentCheck != null) {
			studentCheck.setCheckdate("2012-6-13");
			studentCheck.setStatus(StudentCheck.STATUS_ENABLE);
			studentCheckService.save(studentCheck);
		}
		return list();
	}

	public Page<Student> getPage() {
		return page;
	}

	public List<Student> getStudents() {
		return students;
	}

	public List<InstituteDTO> getInstituteDTOs() {
		return instituteDTOs;
	}

	/**
	 * 
	 * 院系列表
	 * 
	 * @since 2012-6-12
	 * @author chenbo
	 * @return
	 */
	public List<InstituteDTO> getColleges() {
		this.colleges = instituteWebService.getInstitutes();
		if (null == colleges) {
			this.colleges = new ArrayList<InstituteDTO>();
		}
		return colleges;
	}

	/**
	 * 
	 * 专业列表
	 * 
	 * @since 2012-6-12
	 * @author chenbo
	 * @return
	 */
	public List<SpecialtyDTO> getMajors() {
		String collegeCode = request.getParameter("filter_EQS_collegeCode");
		majors = specialtyWebService.getSpecialtysByCollege(collegeCode);
		if (null == majors) {
			this.majors = new ArrayList<SpecialtyDTO>();
		}
		return majors;

	}

	/**
	 * 
	 * 班级列表
	 * 
	 * @since 2012-6-13
	 * @author chenbo
	 * @return
	 */
	public List<ClazzDTO> getClazzes() {
		clazzes = clazzWebService.getClazzsBySpecialty(null, null, null, null);
		if (null == clazzes) {
			this.clazzes = new ArrayList<ClazzDTO>();
		}
		return clazzes;
	}

	/**
	 * 
	 * 批次列表
	 * 
	 * @since 2012-6-12
	 * @author chenbo
	 * @return
	 */
	public List<BatchDTO> getBatches() {
		batches = batchWebService.getAllBatch();
		if (batches == null)
			batches = new ArrayList<BatchDTO>();
		return batches;
	}

}
