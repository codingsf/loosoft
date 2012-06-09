package cn.loosoft.stuwork.backmanage.service.account;

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

import cn.loosoft.stuwork.backmanage.entity.account.Authority;
import cn.loosoft.stuwork.backmanage.entity.account.Role;
import cn.loosoft.stuwork.backmanage.entity.account.User;

import com.google.common.collect.Sets;

/**
 * 实现SpringSecurity的UserDetailsService接口,实现获取用户Detail信息的回调函数.
 * 
 * @author houbing.qian
 */
@Transactional(readOnly = true)
public class UserDetailsServiceImpl implements UserDetailsService {

    private AccountManager accountManager;

    /**
     * 获取用户Details信息的回调函数.
     */
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {


        User user = accountManager.findUserByLoginName(username);
        if (user == null) {
            //add by houbing.qian for be compatible with login with name
            List<User> users = accountManager.findUsersByName(username);
            if (users.size()>1) {
                throw new NotUniqueServiceException("存在多个" + username + "同名用户，请用警号登录");
            }else if(users.isEmpty()){
                throw new UsernameNotFoundException("用户" + username + " 不存在");
            }
            user = users.get(0);
        }


        Set<GrantedAuthority> grantedAuths = obtainGrantedAuthorities(user);

        //-- mini-web示例中无以下属性, 暂时全部设为true. --//
        boolean enabled = true;
        boolean accountNonExpired = true;
        boolean credentialsNonExpired = true;
        boolean accountNonLocked = true;

        /*        UserDetails userdetails = new org.springframework.security.core.userdetails.User(userDTO.getLoginName(), userDTO.getPassword()
        , enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, grantedAuths);*/
        UserDetails userdetails = new cn.loosoft.common.security.springsecurity.user.User(user.getLoginName(), user.getPassword()
                , enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, grantedAuths,user.getName());        

        return userdetails;
    }

    /**
     * 获得用户所有角色的权限集合.
     */
    private Set<GrantedAuthority> obtainGrantedAuthorities(User user) {
        Set<GrantedAuthority> authSet = Sets.newHashSet();
        for (Role role : user.getRoleList()) {
            for (Authority authority : role.getAuthorityList()) {
                authSet.add(new GrantedAuthorityImpl(authority.getPrefixedName()));
            }
        }
        return authSet;
    }

    @Autowired
    public void setAccountManager(AccountManager accountManager) {
        this.accountManager = accountManager;
    }
}
