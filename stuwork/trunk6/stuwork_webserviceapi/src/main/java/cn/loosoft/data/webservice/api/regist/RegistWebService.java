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
package cn.loosoft.data.webservice.api.regist;

import javax.jws.WebParam;
import javax.jws.WebService;

/**
 * 学生注册webservice接口.
 * <p>
 * 使用@WebService将接口中的所有方法输出为Web Service.
 * </p>
 * <p>
 * 可用annotation对设置方法、参数和返回值在WSDL中的定义.
 * </p>
 * 
 * @author yong.geng
 * @version 1.0
 * @since 2011-4-27
 */
@WebService
public interface RegistWebService
{
    /**
     * 
     * 根据通知书号得到考试号
     * 
     * @since 2011-4-27
     * @author yong.geng
     * @return
     */
    public String getExamineeNOByNoticeId(@WebParam(name = "noticeId")
    String noticeId);

    /**
     * 
     * 根据身份证号得到考试号
     * 
     * @since 2011-4-27
     * @author yong.geng
     * @return
     */
    public String getExamineeNOByIDcard(@WebParam(name = "IDcard")
    String IDcard);

    /**
     * 
     * 根据通知书号和身份证号得到考试号
     * 
     * @since 2011-4-27
     * @author yong.geng
     * @return
     */
    public String getExamineeNO(@WebParam(name = "noticeId")
    String noticeId, @WebParam(name = "IDcard")
    String IDcard);

    /**
     * 
     * 根据通知书号和身份证号来判断是否已经注册过
     * 
     * @since 2011-4-27
     * @author yong.geng
     * @return
     */
    public String isRegist(@WebParam(name = "noticeId")
    String noticeId, @WebParam(name = "IDcard")
    String IDcard);

    /**
     * 
     * 保存学生注册信息
     * 
     * @since 2011-4-28
     * @author yong.geng
     * @param noticeId
     * @param IDcard
     * @param password
     * @param email
     */
    public void save(@WebParam(name = "examineeNo")
    String examineeNo, @WebParam(name = "noticeId")
    String noticeId, @WebParam(name = "IDcard")
    String IDcard, @WebParam(name = "password")
    String password, @WebParam(name = "passwordque")
    String passwordque, @WebParam(name = "passwordans")
    String passwordans, @WebParam(name = "email")
    String email);
}
