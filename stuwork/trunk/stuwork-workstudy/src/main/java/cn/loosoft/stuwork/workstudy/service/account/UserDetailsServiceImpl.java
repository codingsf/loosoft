package cn.loosoft.stuwork.workstudy.service.account;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;
import cn.loosoft.data.webservice.api.user.dto.AuthorityDTO;
import cn.loosoft.data.webservice.api.user.dto.RoleDTO;
import cn.loosoft.data.webservice.api.user.dto.UserDTO;
import cn.loosoft.stuwork.common.entity.user.SecurityUser;
import cn.loosoft.stuwork.workstudy.entity.account.Authority;
import cn.loosoft.stuwork.workstudy.entity.account.Role;
import cn.loosoft.stuwork.workstudy.entity.account.User;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

/**
 * 实现SpringSecurity的UserDetailsService接口,实现获取用户Detail信息的回调函数.
 * 
 * @author shanru.wu
 */
@Transactional(readOnly = true)
public class UserDetailsServiceImpl implements UserDetailsService
{
    private AccountManager accountManager;

    /**
     * 获取用户Details信息的回调函数.
     */
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException, DataAccessException
    {
        UserDTO userDTO = null;
        User user = accountManager.getUser(username);
        boolean isYg = false;
        if (null != user)
        {
            isYg = true;
            userDTO = convertToDTO(user);
        }
        else
        {
            userDTO = accountManager.getUserDTO(username);
        }

        if (userDTO == null)
        {
            throw new UsernameNotFoundException("用户" + username + " 不存在");
        }

        Set<GrantedAuthority> grantedAuths = obtainGrantedAuthorities(userDTO);

        // -- mini-web示例中无以下属性, 暂时全部设为true. --//
        boolean enabled = true;
        boolean accountNonExpired = true;
        boolean credentialsNonExpired = true;
        boolean accountNonLocked = true;
        if (isYg)
        {
            grantedAuths.add(new GrantedAuthorityImpl("ROLE_勤工助学_用工人员"));
        }
        /*
         * UserDetails userdetails = new
         * org.springframework.security.core.userdetails
         * .User(userDTO.getLoginName(), userDTO.getPassword() , enabled,
         * accountNonExpired, credentialsNonExpired, accountNonLocked,
         * grantedAuths);
         */

        cn.loosoft.common.security.springsecurity.user.User userdetails = new cn.loosoft.common.security.springsecurity.user.User(
                userDTO.getLoginName(), userDTO.getPassword(), enabled,
                accountNonExpired, credentialsNonExpired, accountNonLocked,
                grantedAuths, userDTO.getName());

        SecurityUser securityUser = new SecurityUser(userdetails, userDTO
                .getDepartCode(), isYg ? String.valueOf(user.getCompName())
                : userDTO.getDepartName(), userDTO.getCollegeCode(), userDTO
                .getCollegeName());

        List<LabelValue> clazzVOList = Lists.newArrayList();
        if (userDTO.getClazzList() != null)
        {
            LabelValue lv = null;
            for (ClazzDTO clazzDTO : userDTO.getClazzList())
            {
                lv = new LabelValue(clazzDTO.getCode(), clazzDTO.getName());
                clazzVOList.add(lv);
            }
        }
        securityUser.setClazzs(clazzVOList);
        return securityUser;
    }

    /**
     * 将User对象转成成UserDTO对象 Description of this Method
     * 
     * @since 2011-3-9
     * @author shanru.wu
     * @param user
     * @return
     */
    @Transactional(readOnly = true)
    private UserDTO convertToDTO(User user)
    {
        if (user == null)
        {
            return null;
        }
        UserDTO userDTO = new UserDTO();
        userDTO.setLoginName(user.getLoginName());
        userDTO.setName(user.getName());
        userDTO.setPassword(user.getPassword());
        userDTO.setCompanyID(user.getCompanyID());
        // SET ROLELIST
        List<Role> roleList = user.getRoleList();
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

        userDTO.setRoleList(roleDTOs);

        return userDTO;
    }

    /**
     * 
     * 获得用户所有角色的权限集合.
     * 
     * @since 2010-8-27
     * @author houbing.qian
     * @param user
     * @return
     */
    private Set<GrantedAuthority> obtainGrantedAuthorities(UserDTO user)
    {
        Set<GrantedAuthority> authSet = Sets.newHashSet();
        for (RoleDTO roleDTO : user.getRoleList())
        {
            for (AuthorityDTO authority : roleDTO.getAuthorityList())
            {
                authSet.add(new GrantedAuthorityImpl(authority
                        .getPrefixedName()));
            }
        }
        return authSet;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager)
    {
        this.accountManager = accountManager;
    }
}
