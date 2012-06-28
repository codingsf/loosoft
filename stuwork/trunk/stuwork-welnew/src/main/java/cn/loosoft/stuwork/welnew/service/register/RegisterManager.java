package cn.loosoft.stuwork.welnew.service.register;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.register.RegisterDao;
import cn.loosoft.stuwork.welnew.entity.register.Register;

@Component
@Transactional
public class RegisterManager extends EntityManager<Register, Long>
{
    private RegisterDao registerDao;

    @Autowired
    public void setRegisterDao(RegisterDao registerDao)
    {
        this.registerDao = registerDao;
    }

    public Register findUniqueByIDCard(String pid, String noticeId)
    {
        String hql = "from Register where pid=? and noticeId=?";
        return registerDao.findUnique(hql, pid, noticeId);
    }

    @Override
    protected HibernateDao<Register, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return registerDao;
    }

}
