package cn.loosoft.stuwork.stuinfo.service.account;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.user.UserWebService;
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
    private UserWebService userWebService;

    // -- User Manager --//
    /**
     * 根据登录名取得用户
     */
    public UserDTO getUser(String loginName)
    {
        return userWebService.getUser(loginName);
    }

    public void saveUser(UserDTO entity)
    {
        logger.debug("do nothing");
        // userDao.save(entity);
    }

}
