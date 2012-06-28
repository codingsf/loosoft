package cn.loosoft.stuwork.selfhelp.service.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.data.webservice.api.student.dto.StudentDTO;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;

/**
 * 安全相关实体的管理类, 包括用户,角色,资源与授权类.
 * 
 * @author houbing.qian
 */
// Spring Bean的标识.
@Component
public class AccountManager
{

    private static Logger  logger = LoggerFactory
                                          .getLogger(AccountManager.class);

    @Autowired
    private StudentWebService studentWebService;

    // -- User Manager --//
    /**
     * 根据登录名取得学生用户
     */
    public StudentDTO getStudentUser(String loginName)
    {
        return studentWebService.getStudentByStudentNo(loginName);

/*        if(s==null)return null;
        return convertToDTO(s);*/
    }

    public void saveUser(UserDTO entity)
    {
        logger.debug("do nothing");
        // userDao.save(entity);
    }

    private UserDTO convertToDTO(StudentDTO user)
    {
        if (user == null)
        {
            return null;
        }
        UserDTO userDTO = new UserDTO();
        userDTO.setLoginName(user.getStudentNo());
        userDTO.setName(user.getName());
        userDTO.setPassword(user.getPassword());
        userDTO.setExamineeNo(user.getExamineeNo());
        //userDTO.setCompanyID(user.getCompanyID());
        // SET ROLELIST
/*        List<Role> roleList = user.getRoleList();
        RoleDTO roleDTO = null;
        List<RoleDTO> roleDTOs = Lists.newArrayList();
        for (Role role : roleList)
        {
            roleDTO = new RoleDTO();
            roleDTO.setName(role.getName());
            roleDTO.setAuthNames(role.getAuthNames());
            // set authority
            AuthorityDTO authorityDTO = null;
            List<AuthorityDTO> authorityDTOs = Lists.newArrayList();
            for (Authority authority : role.getAuthorityList())
            {
                authorityDTO = new AuthorityDTO();
                authorityDTO.setPrefixedName(authority.getPrefixedName());
                authorityDTOs.add(authorityDTO);
            }
            roleDTO.setAuthorityList(authorityDTOs);

            roleDTOs.add(roleDTO);
        }

        userDTO.setRoleList(roleDTOs);*/

        return userDTO;
    }
}
