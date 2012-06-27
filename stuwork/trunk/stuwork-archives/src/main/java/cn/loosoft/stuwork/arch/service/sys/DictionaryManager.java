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
package cn.loosoft.stuwork.arch.service.sys;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.arch.dao.sys.DictionaryDao;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;

/**
 * 系统字典实体的管理类.
 * 
 * @author shanru.wu
 * @since 2010-12-17
 * @version 1.0
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class DictionaryManager extends EntityManager<Dictionary, Long>
{

    private final static String DICTIONARY_QUERY = "from Dictionary where type=?";

    DictionaryDao               dictionaryDao;

    /**
     * 
     * 根据类型查询系统字典信息.
     * 
     * @since 2010-12-17
     * @author shanru.wu
     * @param page
     * @param type
     * @return
     */
    public Page<Dictionary> search(Page<Dictionary> page, String type)
    {
        return dictionaryDao.findPage(page, DICTIONARY_QUERY, type);
    }

    /**
     * 
     * 根据类型查询系统字典信息.
     * 
     * @since 2010-12-17
     * @author shanru.wu
     * @param page
     * @param type
     * @return
     */
    public List<Dictionary> getByType(String type)
    {
        return dictionaryDao.find(DICTIONARY_QUERY, type);
    }

    /**
     * 
     * 根据类型查询系统字典信息.
     * 
     * @since 2010-12-18
     * @author shanru.wu
     * @param type
     * @return
     */
    public List<Dictionary> list(String type)
    {
        return dictionaryDao.find(DICTIONARY_QUERY, type);
    }

    /**
     * 
     * 判断系统字典中的值是否唯一.
     * 
     * @since 2010-12-24
     * @author shanru.wu
     * @param value
     * @return
     */
    public boolean isPropertyUnique(String value, String type)
    {
        boolean isUnique = true;
        List<Dictionary> dictionaries = dictionaryDao.find(DICTIONARY_QUERY,
                type);
        for (int i = 0; i < dictionaries.size(); i++)
        {
            Dictionary dictionary = dictionaries.get(i);
            if (value.equals(dictionary.getValue()))
            {
                isUnique = false;
            }
        }
        return isUnique;
    }

    /**
     * 
     * 批量删除系统字典信息.
     * 
     * @since 2010-12-17
     * @author shanru.wu
     * @param ids
     */
    public void deletes(List<Long> ids)
    {
        dictionaryDao.deletes(ids);
    }

    @Autowired
    public void setDictionaryDao(DictionaryDao dictionaryDao)
    {
        this.dictionaryDao = dictionaryDao;
    }

    @Override
    protected HibernateDao<Dictionary, Long> getEntityDao()
    {
        return dictionaryDao;
    }

}
