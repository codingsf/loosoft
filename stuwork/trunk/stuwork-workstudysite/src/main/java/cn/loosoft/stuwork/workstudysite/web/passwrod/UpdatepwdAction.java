package cn.loosoft.stuwork.workstudysite.web.passwrod;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springside.modules.security.springsecurity.SpringSecurityUtils;
import org.springside.modules.web.struts2.Struts2Utils;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.security.springsecurity.user.User;
import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.springside.web.CrudActionSupport;

/**
 * 
 * 岗位申请Action.
 * 
 * @author shanru.wu
 * @version 1.0
 * @since 2011-3-9
 */
@Namespace("/pwd")
public class UpdatepwdAction extends CrudActionSupport<Object>
{
    HttpServletRequest        request          = Struts2Utils.getRequest();

    @Autowired
    private StudentWebService studentWebService;

    /**
     * serialVersionUID long
     */
    private static final long serialVersionUID = 1L;

    /**
     * 进入修改密码的页面
     * 
     * @since 2011-10-14
     * @see cn.loosoft.springside.web.CrudActionSupport#input()
     */
    @Override
    public String input() throws Exception
    {
    	cn.loosoft.common.security.springsecurity.user.User user = (cn.loosoft.common.security.springsecurity.user.User) SpringSecurityUtils.getCurrentUser();
        request.setAttribute("userName", user.getUsername());
        request.setAttribute("name", user.getName());
        
        return INPUT;
    }

    /**
     * Ajax　判断密码是否输入正确 Description of this Method
     * 
     * @since 2011-10-14
     * @author fangyong
     * @return
     */
    public String checkLoginPwd()
    {
        String oldPwd = request.getParameter("oldPwd");

        User user = (User) SpringSecurityUtils.getCurrentUser();

        StudentDTO studentDTO = studentWebService.getStudentByStudentNo(user
                .getUsername());

        if (oldPwd.equals(studentDTO.getPassword()))
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
     * 
     * 修改密码
     * 
     * @since 2011-10-14
     * @author fangyong
     * @return
     * @throws Exception
     */
    public String savePwd() throws Exception
    {
        String pwd = ParamUtils.getParameter(request, "pwd", null);
        if (StringUtils.isNotBlank(pwd))
        {
            User user = (User) SpringSecurityUtils.getCurrentUser();

            StudentDTO studentDTO = studentWebService
                    .getStudentByStudentNo(user.getUsername());
            studentDTO.setPassword(pwd);

            studentWebService.saveStudent(studentDTO);
            addActionMessage("恭喜您,密码修改成功");
            request.setAttribute("userName", user.getUsername());
        }
        return "input";
    }

    @Override
    public String list() throws Exception
    {
        return SUCCESS;
    }

    @Override
    protected void prepareModel() throws Exception
    {
    }

    @Override
    public String save() throws Exception
    {
        return null;
    }

    public Object getModel()
    {
        return null;
    }

}
