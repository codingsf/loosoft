package cn.loosoft.stuwork.workstudy.web.account;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.InstituteWebService;
import cn.loosoft.data.webservice.api.school.dto.InstituteDTO;
import cn.loosoft.springside.service.ServiceException;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.workstudy.entity.account.Role;
import cn.loosoft.stuwork.workstudy.entity.account.User;
import cn.loosoft.stuwork.workstudy.entity.company.Company;
import cn.loosoft.stuwork.workstudy.service.account.AccountManager;
import cn.loosoft.stuwork.workstudy.service.company.CompanyManager;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数. 演示带分页的管理界面.
 * 
 * @author calvin
 */
// 定义URL映射对应/account/user!input.action
@Namespace("/account")
// 定义名为reload的result重定向到user.action, 其他result则按照convention默认.
@Results( { @Result(name = CrudActionSupport.RELOAD, location = "user.action", type = "redirect") })
public class UserAction extends CrudActionSupport<User> {

	private static final long serialVersionUID = 1L;

	@Autowired
	private AccountManager accountManager;

	@Autowired
	private CompanyManager companyManager;

	private InstituteWebService instituteWebService;

	// -- 页面属性 --//
	private Long id;

	private User entity;

	private Long companyId;

	private String instituteCode;

	private Page<User> page = new Page<User>(20); // 每页11条记录

	private List<Long> checkedRoleIds; // 页面中钩选的角色id列表

	private String userType;

	private List<Long> ids; // 批量id

	public List<LabelValue> radioList;

	// key
	private List<Company> companyList;

	private List<InstituteDTO> instituteList;

	// -- ModelDriven 与 Preparable函数 --//
	public void setId(Long id) {
		this.id = id;
	}

	public User getModel() {
		return entity;
	}

	@Override
	protected void prepareModel() throws Exception {
		if (id != null) {
			entity = accountManager.getUser(id);
		} else {
			entity = new User();
		}
	}

	// -- CRUD Action 函数 --//
	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateUtils
				.buildPropertyFilters(Struts2Utils.getRequest());
		// 设置默认排序方式
		if (!page.isOrderBySetted()) {
			page.setOrderBy("id");
			page.setOrder(Page.ASC);
		}
		page = accountManager.searchUser(page, filters);
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {
		checkedRoleIds = entity.getRoleIds();
		// 填充单位数据
		companyId = entity.getCompany() != null ? entity.getCompany().getId()
				: null;
		companyList = companyManager.getAll();

		// 填充学院数据
		instituteCode = entity.getInstituteCode() != null ? entity
				.getInstituteCode() : "";
		instituteList = instituteWebService.getInstitutes();

		return INPUT;
	}

	@Override
	public String save() throws Exception {
		// 根据页面上的checkbox选择 整合User的Roles Set
		HibernateUtils.mergeByCheckedIds(entity.getRoleList(), checkedRoleIds,
				Role.class);
		if ("3".equals(userType)) {
			entity.setCompany(companyManager.get(companyId));
			entity.setCompName(companyManager.get(companyId).getCompanyName());
		}
		if ("2".equals(userType)) {
			entity.setInstituteCode(instituteCode);
			entity.setInstituteName(instituteWebService
					.getInstituteName(instituteCode));
		}
		// 由于页面的学院代码的name是instituteCode，和user实体类的属性相同。
		// 保存的时候，如果页面上面选择一次学院代码的话，那么学院代码会被自动保存进去。
		// 所以这里要进行情空。
		if ("1".equals(userType)) {
			entity.setInstituteCode("");
		}

		entity.setCreateDate(new Date());
		accountManager.saveUser(entity);
		addActionMessage("保存用户成功");
		return RELOAD;
	}

	@Override
	public String delete() throws Exception {
		try {
			accountManager.deleteUser(id);
			addActionMessage("删除用户成功");
		} catch (ServiceException e) {
			logger.error(e.getMessage(), e);
			addActionMessage("删除用户失败,原因：" + e.getMessage());
		}
		return RELOAD;
	}

	public String deletes() throws Exception {
		for (Long lon : ids) {
			try {
				accountManager.deleteUser(lon);
				addActionMessage("删除用户成功");
			} catch (ServiceException e) {
			}

		}
		return RELOAD;

	}

	public void setIds(List<Long> ids) {
		this.ids = ids;
	}

	// -- 其他Action函数 --//
	/**
	 * 支持使用Jquery.validate Ajax检验用户名是否重复.
	 */
	public String checkLoginName() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String newLoginName = request.getParameter("loginName");
		String oldLoginName = request.getParameter("oldLoginName");

		if (accountManager.isLoginNameUnique(newLoginName, oldLoginName)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		// 因为直接输出内容而不经过jsp,因此返回null.
		return null;
	}

	/**
	 * 检测用户名和密码
	 * 
	 * @return
	 */
	public String checkLoginNamePwd() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String up = request.getParameter("up");
		String loginName = up == null ? "" : up.substring(0, up
				.lastIndexOf("_"));
		String password = up == null ? "" : up
				.substring(up.lastIndexOf("_") + 1);
		User user = accountManager.findUserByLoginName(loginName);
		if (user == null) {
			List<User> users = accountManager.findUsersByName(loginName);
			if (users.isEmpty() || users.size() > 1) {
				Struts2Utils.renderText("false");
				return null;
			} else {
				user = users.get(0);
			}
		}

		if (user.getPassword().equals(password)) {
			Struts2Utils.renderText("true");
		} else {
			Struts2Utils.renderText("false");
		}
		// 因为直接输出内容而不经过jsp,因此返回null.
		return null;
	}

	// -- 页面属性访问函数 --//
	/**
	 * list页面显示用户分页列表.
	 */
	public Page<User> getPage() {
		return page;
	}

	/**
	 * input页面显示所有角色列表.
	 */
	public List<Role> getAllRoleList() {
		return accountManager.getAllRole();
	}

	/**
	 * input页面显示用户拥有的角色.
	 */
	public List<Long> getCheckedRoleIds() {
		return checkedRoleIds;
	}

	/**
	 * input页面提交用户拥有的角色.
	 */
	public void setCheckedRoleIds(List<Long> checkedRoleIds) {
		this.checkedRoleIds = checkedRoleIds;
	}

	public Long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public List<Company> getCompanyList() {
		return companyList;
	}

	public void setCompanyList(List<Company> companyList) {
		this.companyList = companyList;
	}

	public String getInstituteCode() {
		return instituteCode;
	}

	public void setInstituteCode(String instituteCode) {
		this.instituteCode = instituteCode;
	}

	public InstituteWebService getInstituteWebService() {
		return instituteWebService;
	}

	@Autowired
	public void setInstituteWebService(InstituteWebService instituteWebService) {
		this.instituteWebService = instituteWebService;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public List<InstituteDTO> getInstituteList() {
		return instituteList;
	}

	public void setInstituteList(List<InstituteDTO> instituteList) {
		this.instituteList = instituteList;
	}

	/**
	 * 页面radio集合
	 */
	public List<LabelValue> getRadioList() {
		radioList = new ArrayList<LabelValue>();
		radioList.add(new LabelValue("1", "校勤工助学指导中心"));
		radioList.add(new LabelValue("2", "院系勤工助学领导小组"));
		radioList.add(new LabelValue("3", "用工单位"));
		return radioList;
	}
}
