//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Digital. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Digital
//
// Original author: Administrator
//
//-------------------------------------------------------------------------
// LOOSOFT MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
// THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE, OR NON-INFRINGEMENT. UFINITY SHALL NOT BE
// LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING,
// MODIFYING OR DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
//
// THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
// CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
// PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
// NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
// SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
// SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
// PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES"). UFINITY
// SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
// HIGH RISK ACTIVITIES.
//-------------------------------------------------------------------------
package cn.loosoft.stuwork.arch.dao.store;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Component;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.stuwork.arch.entity.store.Store;

/**
 * 
 * 档案柜管理DAO.
 * 
 * @author jie.yang
 * @version 1.0
 * @since 2010-12-17
 */
@Component
public class StoreDao extends HibernateDao<Store, Long>
{
    private static final String DELETE_STORE = "delete from Store where id in(:ids)";

    /**
     * 批量删除档案柜.
     */
    public void deletes(List<Long> ids)
    {
        Map<String, List<Long>> map = Collections.singletonMap("ids", ids);
        batchExecute(DELETE_STORE, map);
    }

    /**
     * 根据区域和排查找
     */
    public Store findRank(String area, int rank)
    {
        String hql = "from Store where area='" + area + "' and rank=" + rank;
        Query queryObject = null;
        try
        {
            queryObject = getClearSession().createQuery(hql);
        }
        catch (HibernateException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (Exception e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        queryObject.setCacheable(false);
        if (queryObject.list().size() > 0)
        {
            return (Store) queryObject.list().get(0);
        }
        else
        {
            return null;
        }

    }

    /**
     * 根据区域 排 行 查找所有.
     */
    public List<Store> getAll(String area, int rank, int row)
    {
        StringBuffer sb = new StringBuffer();
        if (area != "" && area != null)
        {
            sb.append(" from Store  where area='" + area + "'");
        }
        if (rank != 0)
        {
            sb.append(" and rank=" + rank + "");
        }
        if (row != 0)
        {
            sb.append(" and storow=" + row);
        }
        sb.append(" order by id asc");
        Query query = super.createQuery(sb.toString());
        return query.list();

    }

    /**
     * 查询所有档案柜.
     */
    public List<Store> getAllArea()
    {

        String hql = "from Store s group by area";
        Query query = super.createQuery(hql);
        return query.list();
    }

    /**
     * 使用hibernate查询后不更新
     * 
     * @since 2010-11-23
     * @author Administrator
     * @return
     * @throws Exception
     */
    public Session getClearSession() throws Exception
    {

        Session session = super.getSession();
        if (session == null || !session.isOpen())
        {
            if (super.sessionFactory == null)
            {

            }
            session = (super.sessionFactory != null) ? sessionFactory
                    .openSession() : null;

        }
        session.clear();
        return session;
    }

}
