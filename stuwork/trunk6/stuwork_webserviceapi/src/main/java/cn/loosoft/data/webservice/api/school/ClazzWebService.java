//-------------------------------------------------------------------------
// Copyright (c) 2000-2010 Loosoft. All Rights Reserved.
//
// This software is the confidential and proprietary information of
// Loosoft
//
// Original author: houbing.qian
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
package cn.loosoft.data.webservice.api.school;

import java.util.List;

import javax.jws.WebParam;
import javax.jws.WebService;

import cn.loosoft.data.webservice.api.school.dto.ClazzDTO;


/**
 * 班级webservice接口.
 * <p>
 * 使用@WebService将接口中的所有方法输出为Web Service.
 * </p>
 * <p>
 * 可用annotation对设置方法、参数和返回值在WSDL中的定义.
 * </p> 
 * @author            houbing.qian
 * @version           1.0
 * @since             2010-8-22
 */
@WebService
public interface ClazzWebService
{
    /**
     * 
     * 根据专业，年份，季度取得班级
     * @since  2010-8-22
     * @author houbing.qian
     * @param code 专业代码
     * @param year 入学年份
     * @param season 入学季节
     * @return
     */
    List<ClazzDTO> getClazzsBySpecialty(@WebParam(name="code") String code,@WebParam(name="type") String type,
            @WebParam(name="year") String year,
            @WebParam(name="season") String season);
    /**
     * 
     * 根据专业，年份，季度取得班级的串，多个班级之间用逗号隔开
     * @since  2010-8-25
     * @author houbing.qian
     * @param code 专业代码
     * @param year 入学年份
     * @param season 入学季节
     * @return
     */
    String getClazzStrBySpecialty(@WebParam(name="code") String code,@WebParam(name="type") String type,
            @WebParam(name="year") String year,
            @WebParam(name="season") String season);

    /**
     * 
     * 根据取得名称
     * @since  2010-8-22
     * @author houbing.qian
     * @param code 班级代码
     * @return
     */
    String getClazzName(@WebParam(name="code") String code);

    /**
     * 
     * 根据班级名称取得代码
     * @since  2010-8-22
     * @author houbing.qian
     * @param code
     * @param year
     * @param season
     * @return
     */
    String getClazzCodeByName(@WebParam(name="name") String name,@WebParam(name="type") String type,
            @WebParam(name="year") String year,
            @WebParam(name="season") String season);

    /**
     * 
     * 持久化列表中的班级
     * @since  2010-8-25
     * @author houbing.qian
     * @param clazzs
     * @return
     */
    String saveClazzs(@WebParam(name="name") List<ClazzDTO> clazzs);
}
