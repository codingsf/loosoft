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
package cn.loosoft.stuwork.welnew.webservice.regist;

import javax.jws.WebService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.loosoft.data.webservice.api.regist.RegistWebService;
import cn.loosoft.stuwork.welnew.entity.register.Register;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.register.RegisterManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;

/**
 * 学生注册的webservice实现类 使用@WebService指向Interface定义类即可.
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-4-27
 */
// Spring Bean的标识.
@Component
@WebService(endpointInterface = "cn.loosoft.data.webservice.api.regist.RegistWebService")
public class RegistWebServiceImpl implements RegistWebService
{
    @Autowired
    private StudentManager  studentManager;

    @Autowired
    private RegisterManager registerManger;

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-28
     * @see cn.loosoft.data.webservice.api.regist.RegistWebServicce#getExmamineeNO(java.lang.String,
     *      java.lang.String)
     */
    public String getExamineeNO(String noticeId, String IDcard)
    {
        Student student = studentManager.getByNoticeIdAndIDcard(noticeId,
                IDcard);
        if (student == null)
        {
            return null;
        }
        else
        {
            return student.getExamineeNo();
        }
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-28
     * @see cn.loosoft.data.webservice.api.regist.RegistWebServicce#getExmamineeNOByAdmissionNo(java.lang.String)
     */
    public String getExamineeNOByNoticeId(String noticeId)
    {
        Student student = studentManager.getByNoticeId(noticeId);
        if (student == null)
        {
            return null;
        }
        else
        {
            return student.getExamineeNo();
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-28
     * @see cn.loosoft.data.webservice.api.regist.RegistWebServicce#getExmamineeNOByIDcard(java.lang.String)
     */
    public String getExamineeNOByIDcard(String IDcard)
    {
        Student student = studentManager.getByIDcard(IDcard);
        if (student == null)
        {
            return null;
        }
        else
        {
            return student.getExamineeNo();
        }
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-28
     * @see cn.loosoft.data.webservice.api.regist.RegistWebService#isRegist(java.lang.String,
     *      java.lang.String)
     */
    public String isRegist(String noticeId, String IDcard)
    {
        Register register = registerManger.findUniqueByIDCard(IDcard, noticeId);
        if (register != null)
        {
            return "exsist";
        }
        else
        {
            return "ok";
        }

    }

    /**
     * {@inheritDoc}
     * 
     * @since 2011-4-28
     * @see cn.loosoft.data.webservice.api.regist.RegistWebService#save(java.lang.String,
     *      java.lang.String, java.lang.String, java.lang.String)
     */
    public void save(String examineeNo, String noticeId, String IDcard,
            String password, String passwordque, String passwordans,
            String email)
    {
        Register register = new Register();
        register.setLoginName(examineeNo);
        register.setNoticeId(noticeId);
        register.setPid(IDcard);
        register.setPassword(password);
        register.setPasswordque(passwordque);
        register.setPasswordans(passwordans);
        register.setEmail(email);

        registerManger.save(register);

    }

}
