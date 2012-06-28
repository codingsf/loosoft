package cn.loosoft.stuwork.welnew.dao.register;

import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.welnew.entity.register.Register;

/**
 * 
 * 新生注册DAO.
 * 
 * @author bo.chen
 * @version 1.0
 * @since 2010-12-2
 */
@Component
public class RegisterDao extends HibernateDao<Register, Long>
{
    public Register findUniqeByIDCard(String IDCard)
    {
        return super.findUniqueBy("pid", IDCard);
    }
}
