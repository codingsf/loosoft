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
package cn.loosoft.stuwork.welnew.service.log;

import java.text.DecimalFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.welnew.dao.log.DevolverLogDao;
import cn.loosoft.stuwork.welnew.dao.student.StudentDao;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.log.DevolverLog;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.vo.DevolverCoVO;
import cn.loosoft.stuwork.welnew.vo.DevolverQXVO;

import com.google.common.collect.Lists;

/**
 * 
 * 转移记录的管理类.
 * 
 * @author jie.yang
 */
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class DevolverLogManager extends EntityManager<DevolverLog, Long>
{

    @Autowired
    private DevolverLogDao devolverLogDao;

    @Autowired
    private StudentDao     studentDao;

    /**
     * 
     * 根据学号查询所有转移记录
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @param studentNo
     * @return
     */
    public List<DevolverLog> getStudentDevolverLog(String studentNo)
    {

        return devolverLogDao.findBy("studentNo", studentNo);
    }

    /**
     * 
     * 根据学号查询所有转移记录
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @param studentNo
     * @return
     */
    public DevolverLog getStudentLog(String studentNo, int devolverId)
    {

        return devolverLogDao.getStudentLog(studentNo, devolverId);

    }

    /**
     * 
     * 根据转移项目编号查询转移记录
     * 
     * @since 2010-12-29
     * @author jie.yang
     * @param studentNo
     * @return
     */
    public DevolverLog getDevolverLog(int devolverId)
    {
        return devolverLogDao.findUniqueBy("devolverId", devolverId);
    }

    /**
     * 
     * 全校统计
     * 
     * @since 2011-9-2
     * @author qingang
     * @param welbatch批次
     * @param num
     *            报到人数
     * @return
     */
    public List<DevolverQXVO> getCountQX(Welbatch welbatch, long num)
    {
        List<DevolverQXVO> devolverQXVO = Lists.newArrayList();
        List dl = devolverLogDao.getCountQX(welbatch);

        DecimalFormat decimal = new DecimalFormat("0.00");
        for (int i = 0; i < dl.size(); i++)
        {
            Object[] b = (Object[]) dl.get(i);
            DevolverQXVO d = new DevolverQXVO();
            d.setZnum(num);
            d.setYnum((Long) b[0]);
            d.setVnum(num - (Long) b[0]);
            d.setRate(decimal.format((double) (Long) b[0] * 100 / num) + "%");
            d.setItemname((String) b[1]);

            devolverQXVO.add(d);
        }
        return devolverQXVO;
    }

    /**
     * 
     * 按学院、项目统计
     * 
     * @since 2011-9-2
     * @author qingang
     * @param welbatch
     * @param num
     * @return
     */
    public List<DevolverCoVO> getCountByCollege(Welbatch welbatch, long num)
    {
        List<Student> students = studentDao
        .getGroupStudentsByMajor(welbatch);
        List<DevolverCoVO> devolvers = Lists.newArrayList();
        if (!students.isEmpty())
        {
            for (Student student : students)
            {
                List<DevolverQXVO> devolverQXVO = Lists.newArrayList();
                String collegeName = student.getCollegeName();
                List dl = devolverLogDao.getCountByCollege(welbatch,
                        collegeName);

                DecimalFormat decimal = new DecimalFormat("0.00");
                if (!dl.isEmpty())
                {
                    for (int i = 0; i < dl.size(); i++)
                    {
                        Object[] b = (Object[]) dl.get(i);
                        DevolverQXVO d = new DevolverQXVO();
                        d.setZnum(num);
                        d.setYnum((Long) b[0]);
                        d.setVnum(num - (Long) b[0]);
                        d.setRate(decimal.format((double) (Long) b[0] * 100
                                / num)
                                + "%");
                        d.setItemname((String) b[1]);
                        devolverQXVO.add(d);
                    }
                    DevolverCoVO dc = new DevolverCoVO();
                    dc.setCollegeName(collegeName);
                    dc.setDevolvers(devolverQXVO);
                    devolvers.add(dc);
                }
            }
        }
        return devolvers;

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-11-11
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<DevolverLog, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return devolverLogDao;
    }

}
