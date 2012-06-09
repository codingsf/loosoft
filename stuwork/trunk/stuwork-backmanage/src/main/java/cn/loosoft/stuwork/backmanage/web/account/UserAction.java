package cn.loosoft.stuwork.backmanage.web.account;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.PropertyFilter;
import org.springside.modules.orm.hibernate.HibernateUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.date.DateUtils;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.service.ServiceException;
import cn.loosoft.springside.util.ParamPropertyUtils;
import cn.loosoft.springside.web.CrudActionSupport;
import cn.loosoft.stuwork.backmanage.entity.account.Role;
import cn.loosoft.stuwork.backmanage.entity.account.User;
import cn.loosoft.stuwork.backmanage.entity.batch.Batch;
import cn.loosoft.stuwork.backmanage.entity.school.Clazz;
import cn.loosoft.stuwork.backmanage.entity.school.Institute;
import cn.loosoft.stuwork.backmanage.entity.school.Specialty;
import cn.loosoft.stuwork.backmanage.service.account.AccountManager;
import cn.loosoft.stuwork.backmanage.service.batch.BatchManager;
import cn.loosoft.stuwork.backmanage.service.school.ClazzManager;
import cn.loosoft.stuwork.backmanage.service.school.InstituteManager;
import cn.loosoft.stuwork.backmanage.service.school.SpecialtyManager;

/**
 * 用户管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数. 演示带分页的管理界面.
 * 
 * @author shanru.wu
 */
// 定义URL映射对应/account/user!input.action
@Namespace("/account")
// 定义名为reload的result重定向到user.action, 其他result则按照convention默认.
@Results( {
        @Result(name = CrudActionSupport.RELOAD, location = "user.action", type = "redirect"),
        @Result(name = "stu", location = "batchStuUser.jsp") })
public class UserAction extends CrudActionSupport<User>
{

    private static final long serialVersionUID = 1L;

    private String            collegeCode      = "";

    private String            majorCode        = "";

    private String            classCode        = "";

    private StudentWebService studentWebService;

    @Autowired
    private AccountManager    accountManager;

    private BatchManager      batchManager;

    @Autowired
    private InstituteManager  instituteManager;

    @Autowired
    private SpecialtyManager  specialtyManager;

    @Autowired
    private ClazzManager      clazzManager;

    // -- 页面属性 --//
    private Long              id;

    private User              entity;

    private Page<User>        page             = new Page<User>(20); // 每页11条记录

    private List<Long>        checkedRoleIds;                       // 页面中钩选的角色id列表

    private List<String>      clazzCodeList;                        // 页面中勾选的班级code列表

    private List<Institute>   collegues;                            // 学院列表

    private List<Specialty>   majors;                               // 专业列表

    private List<Clazz>       clazzs;                               // 班级列表

    private List<Batch>       batchs;                               // 批次列表

    // -- ModelDriven 与 Preparable函数 --//
    public void setId(Long id)
    {
        this.id = id;
    }

    public User getModel()
    {
        return entity;
    }

    @Override
    protected void prepareModel() throws Exception
    {
        if (id != null)
        {
            entity = accountManager.getUser(id);
        }
        else
        {
            entity = new User();
        }
    }

    // -- CRUD Action 函数 --//
    @Override
    public String list() throws Exception
    {
        List<PropertyFilter> filters = HibernateUtils
                .buildPropertyFilters(Struts2Utils.getRequest());
        ParamPropertyUtils.replacePropertyRule(filters);
        // 设置默认排序方式
        if (!page.isOrderBySetted())
        {
            page.setOrderBy("id");
            page.setOrder(Page.ASC);
        }
        page = accountManager.searchUser(page, filters);
        return SUCCESS;
    }

    @Override
    public String input() throws Exception
    {
        // 给系的学院赋页面id域的值
        this.collegeCode = entity.getInstitute() != null ? entity
                .getInstitute().getCode() : "";
        this.majorCode = entity.getSpecialty() == null ? "" : entity
                .getSpecialty().getCode();
        checkedRoleIds = entity.getRoleIds();
        return INPUT;
    }

    /**
     * 
     * 跳转到批量创建学生页面
     * 
     * @since 2011-4-19
     * @author yong.geng
     * @return
     */
    public String createStuUser()
    {
        return "stu";
    }

    /**
     * 
     * 保存批量创建学生用户
     * 
     * @since 2011-4-19
     * @author yong.geng
     * @return
     */
    public String saveBatchStuUser()
    {
        try
        {
            HttpServletRequest request = ServletActionContext.getRequest();
            String choseLoginName = request.getParameter("loginName");
            String chosePassword = request.getParameter("password");

            String clazzCodeString = "";
            // 处理班级code和班级名称，以逗号分隔,以便传到hql语句里面使用
            if (null != this.clazzCodeList && this.clazzCodeList.size() > 0)
            {
                for (int i = 0; i < clazzCodeList.size(); i++)
                {
                    clazzCodeString = clazzCodeString + ",'"
                            + clazzCodeList.get(i) + "'";
                }
                clazzCodeString = clazzCodeString.substring(1, clazzCodeString
                        .length());
            }
            List<StudentDTO> stuList = studentWebService.getBatchStu(
                    collegeCode, majorCode, clazzCodeString);
            List<Role> roleList = new ArrayList<Role>();
            for (int i = 0; i < checkedRoleIds.size(); i++)
            {
                Role role = new Role();
                role.setId(checkedRoleIds.get(i));
                roleList.add(role);
            }

            if (stuList != null)
            {
                for (int i = 0; i < stuList.size(); i++)
                {
                    User user = new User();
                    // 根据选择的字段做为登录名
                    if (Integer.parseInt(choseLoginName) == 0)
                    {
                        user.setLoginName(stuList.get(i).getName());
                    }
                    if (Integer.parseInt(choseLoginName) == 1)
                    {
                        user.setLoginName(stuList.get(i).getStudentNo());
                    }
                    if (Integer.parseInt(choseLoginName) == 2)
                    {
                        user.setLoginName(stuList.get(i).getExamineeNo());
                    }
                    // 根据选择的字段做为密码
                    if (Integer.parseInt(chosePassword) == 1)
                    {
                        user.setPassword(stuList.get(i).getStudentNo());
                    }
                    if (Integer.parseInt(chosePassword) == 2)
                    {
                        user.setPassword(stuList.get(i).getExamineeNo());
                    }

                    user.setName(stuList.get(i).getName());
                    user.setEmail(stuList.get(i).getEmail());
                    user.setExamineeNo(stuList.get(i).getExamineeNo());
                    user.setCreateDate(DateUtils.getNowTimestamp());
                    user.setClazzCode(stuList.get(i).getClassCode());
                    user.setClazzName(stuList.get(i).getClassName());
                    Institute institute = instituteManager.getByCode(stuList
                            .get(i).getCollegeCode());
                    user.setInstitute(institute);
                    Specialty specialty = specialtyManager.getByCode(stuList
                            .get(i).getMajorCode());
                    user.setSpecialty(specialty);
                    user.setRoleList(roleList);

                    accountManager.saveUser(user);

                }
            }

            addActionMessage("批量保存用户成功!");

        }
        catch (Exception e)
        {
            addActionMessage("批量保存用户失败，可能用户名重复!");
        }
        return "stu";

    }

    @Override
    public String save() throws Exception
    {
        // 根据页面上的checkbox选择 整合User的Roles Set
        HibernateUtils.mergeByCheckedIds(entity.getRoleList(), checkedRoleIds,
                Role.class);
        // set institute
        if (null != collegeCode && StringUtils.isNotEmpty(collegeCode))
        {
            entity.setInstitute(instituteManager.getByCode(collegeCode));
        }
        else
        {
            entity.setInstitute(null);
        }
        if (null != majorCode && StringUtils.isNotEmpty(majorCode))
        {
            entity.setSpecialty(specialtyManager.getByCode(majorCode));
        }
        else
        {
            entity.setSpecialty(null);
        }

        String clazzCodeString = "";
        String clazzNameString = "";
        // 处理班级code和班级名称，以逗号分隔存放
        if (null != this.clazzCodeList && this.clazzCodeList.size() > 0)
        {
            for (int i = 0; i < clazzCodeList.size(); i++)
            {
                clazzCodeString = clazzCodeString + ",'" + clazzCodeList.get(i)
                        + "'";
                clazzNameString = clazzNameString
                        + ","
                        + clazzManager.getByCode(clazzCodeList.get(i))
                                .getName();
            }
            clazzCodeString = clazzCodeString.substring(1, clazzCodeString
                    .length());
            clazzNameString = clazzNameString.substring(1, clazzNameString
                    .length());
            entity.setClazzCode(clazzCodeString);
            entity.setClazzName(clazzNameString);
        }

        entity.setCreateDate(new Date());

        // 如果学院和专业为空，将班级代码和班级名称置为空
        if (null == collegeCode || StringUtils.isEmpty(collegeCode)
                || null == majorCode || StringUtils.isEmpty(majorCode))
        {
            entity.setClazzCode("");
            entity.setClazzName("");
        }

        accountManager.saveUser(entity);
        addActionMessage("保存用户成功");
        return RELOAD;
    }

    @Override
    public String delete() throws Exception
    {
        try
        {
            accountManager.deleteUser(id);
            addActionMessage("删除用户成功");
        }
        catch (ServiceException e)
        {
            logger.error(e.getMessage(), e);
            addActionMessage("删除用户失败,原因：" + e.getMessage());
        }
        return RELOAD;
    }

    // -- 其他Action函数 --//
    /**
     * 支持使用Jquery.validate Ajax检验用户名是否重复.
     */
    public String checkLoginName()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String newLoginName = request.getParameter("loginName");
        String oldLoginName = request.getParameter("oldLoginName");

        if (accountManager.isLoginNameUnique(newLoginName, oldLoginName))
        {
            Struts2Utils.renderText("true");
        }
        else
        {
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
    public String checkLoginNamePwd()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        String up = request.getParameter("up");
        String loginName = up == null ? "" : up.substring(0, up
                .lastIndexOf("_"));
        String password = up == null ? "" : up
                .substring(up.lastIndexOf("_") + 1);
        User user = accountManager.findUserByLoginName(loginName);
        if (user == null)
        {
            List<User> users = accountManager.findUsersByName(loginName);
            if (users.isEmpty() || users.size() > 1)
            {
                Struts2Utils.renderText("false");
                return null;
            }
            else
            {
                user = users.get(0);
            }
        }

        if (user.getPassword().equals(password))
        {
            Struts2Utils.renderText("true");
        }
        else
        {
            Struts2Utils.renderText("false");
        }
        // 因为直接输出内容而不经过jsp,因此返回null.
        return null;
    }

    // -- 页面属性访问函数 --//
    /**
     * list页面显示用户分页列表.
     */
    public Page<User> getPage()
    {
        return page;
    }

    /**
     * input页面显示所有角色列表.
     */
    public List<Role> getAllRoleList()
    {
        return accountManager.getAllRole();
    }

    /**
     * input页面显示用户拥有的角色.
     */
    public List<Long> getCheckedRoleIds()
    {
        return checkedRoleIds;
    }

    /**
     * input页面提交用户拥有的角色.
     */
    public void setCheckedRoleIds(List<Long> checkedRoleIds)
    {
        this.checkedRoleIds = checkedRoleIds;
    }

    public List<Clazz> getClazzs()
    {

        this.clazzs = clazzManager.getClazzsBySpecialty(majorCode, null, null,
                null);
        if (this.clazzs == null)
        {
            this.clazzs = new ArrayList<Clazz>();
        }

        return this.clazzs;
    }

    public List<Specialty> getMajors()
    {
        this.majors = specialtyManager.getSpecialtysByCollege(collegeCode);
        if (this.majors == null)
        {
            this.majors = new ArrayList<Specialty>();
        }
        return this.majors;
    }

    public List<Institute> getCollegues()
    {
        collegues = instituteManager.getAll();
        return collegues;
    }

    public List<Batch> getBatchs()
    {
        this.batchs = batchManager.getAll();
        return batchs;
    }

    // /**
    // * INPUT页面显示用户类型
    // */
    // public List<UserType> getTypes()
    // {
    // this.types = userTypeManager.getAll();
    // return types;
    // }

    public String getCollegeCode()
    {
        return collegeCode;
    }

    public void setCollegeCode(String collegeCode)
    {
        this.collegeCode = collegeCode;
    }

    public String getMajorCode()
    {
        return majorCode;
    }

    public void setMajorCode(String majorCode)
    {
        this.majorCode = majorCode;
    }

    public String getClassCode()
    {
        return classCode;
    }

    public void setClassCode(String classCode)
    {
        this.classCode = classCode;
    }

    public void setClazzCodeList(List<String> clazzCodeList)
    {
        this.clazzCodeList = clazzCodeList;
    }

    @Autowired
    public void setBatchManager(BatchManager batchManager)
    {
        this.batchManager = batchManager;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

}
