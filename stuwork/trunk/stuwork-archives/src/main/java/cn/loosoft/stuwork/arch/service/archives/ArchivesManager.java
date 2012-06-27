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
package cn.loosoft.stuwork.arch.service.archives;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springside.modules.orm.Page;
import org.springside.modules.orm.hibernate.HibernateDao;

import cn.loosoft.data.webservice.api.student.StudentWebService;
import cn.loosoft.springside.service.EntityManager;
import cn.loosoft.stuwork.arch.dao.archives.ArchivesDao;
import cn.loosoft.stuwork.arch.entity.archives.Archives;
import cn.loosoft.stuwork.arch.entity.sys.Dictionary;
import cn.loosoft.stuwork.arch.service.sys.DictionaryManager;
import cn.loosoft.stuwork.arch.util.ExcelUtils;
import cn.loosoft.stuwork.arch.vo.CountVO;

/**
 * 档案实体的管理类.
 * 
 * @author shanru.wu
 * @since 2010-12-18
 * @version 1.0
 */
// Spring Bean的标识.
@Component
// 默认将类中的所有函数纳入事务管理.
@Transactional
public class ArchivesManager extends EntityManager<Archives, Long>
{

    private ArchivesDao       archivesDao;      // 入库dao

    private DictionaryManager dictionaryManager;

    private StudentWebService studentWebService;

    /**
     * 
     * 取得档案材料的串，多个之间用逗号隔开
     * 
     * @since 2010-12-18
     * @author shanru.wu
     * @return
     */
    public String getArchivesStr()
    {
        List<Dictionary> dictionaries = dictionaryManager.list(Dictionary.RKCL);
        StringBuilder sb = new StringBuilder();
        for (Dictionary dictionary : dictionaries)
        {
            sb.append("," + dictionary.getValue());
        }
        return sb.length() > 0 ? sb.substring(1) : "";
    }

    /**
     * 院系统计
     */
    public List<CountVO> collegeCount()
    {
        return archivesDao.collegeCount();
    }

    /**
     * 班级统计
     */
    public List<CountVO> classCount()
    {
        return archivesDao.classCount();
    }

    /**
     * 专业统计
     */
    public List<CountVO> majorCount()
    {
        return archivesDao.majorCount();
    }

    /**
     * 
     * 根据学号查询学生档案信息
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @param stuId
     * @return
     */
    public Archives getArchives(String stuId)
    {
        return archivesDao.findUniqueBy("stuId", stuId);
    }

    /**
     * 
     * 根据考生号查询学生档案信息
     * 
     * @since 2010-12-20
     * @author shanru.wu
     * @param stuId
     * @return
     */
    public Archives getArchivesByExamineeNo(String examineeNo)
    {
        return archivesDao.findUniqueBy("examineeNo", examineeNo);
    }

    public Page<Archives> search(Page<Archives> page, String name,
            String stuId, String examineeNo)
    {
        return archivesDao.search(page, name, stuId, examineeNo);
    }

    /**
     * 
     * 查询状态为空在库和调阅的总记录数
     * 
     * @since 2011-1-16
     * @author shanru.wu
     * @param status
     * @return
     */
    public long countArchives(String stuId, String name)
    {
        return archivesDao.countArchives(stuId, name);
    }

    /**
     * 
     * 从Excel表格中批量导入档案入库信息
     * 
     * @param file
     * @param dstPath
     * @param type
     * @author shanru.wu
     * @since 2010-12-18
     * @return
     */
    public List<String> importArchives(File file, String dstPath)
    {
        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, false);
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, true);
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        Archives archives;
        List<String> result = new ArrayList<String>();
        int total = 0;
        int fail = 0;
        if (null != datas && datas.size() > 1)
        {
            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                try
                {
                    Map<String, String> data = datas.get(i);
                    archives = new Archives();
                    String stuId = ""; // 学号
                    String storeInfo = ""; // 档案信息
                    String name = "";// 姓名
                    for (int j = 0; j < keyList.size(); j++)
                    {
                        String temp = keyList.get(j);
                        if (temp.equals("学号"))
                        {
                            stuId = data.get(temp);
                            archives.setStuId(stuId);
                            continue;
                        }
                        if (temp.equals("姓名"))
                        {
                            name = data.get(temp);
                            archives.setName(name);
                            continue;
                        }
                        if (temp.equals("考生号"))
                        {
                            archives.setExamineeNo(data.get(temp));
                            continue;
                        }
                        if (temp.equals("入库理由"))
                        {
                            archives.setReason(data.get(temp));
                            continue;
                        }
                        if (temp.equals("档案信息"))
                        {
                            archives.setArchivesInfo(data.get(temp)); // 档案信息
                            continue;
                        }
                        if (temp.equals("库位信息"))
                        {
                            storeInfo = data.get(temp);
                            archives.setStoreInfo(storeInfo); // 库位信息
                            continue;
                        }
                        if (temp.equals("移交人"))
                        {
                            archives.setTransfer(data.get(temp));
                        }
                        if (temp.equals("接收人"))
                        {
                            archives.setRecipient(data.get(temp));
                        }

                    }
                    // 判断学生档案是否已存在
                    if (archivesDao.isPropertyUnique("stuId", stuId, ""))
                    {
                        String tempName = studentWebService
                                .getNameByStuId(stuId);
                        if (null != tempName
                                && StringUtils.isNotEmpty(tempName))
                        { // 学生学号和姓名对应
                            if (tempName.equals(name))
                            {
                                // 判断学生档案信息的格式是否正确
                                if (StringUtils.isNotEmpty(storeInfo)
                                        && storeInfo.split("-").length != 4)
                                {
                                    fail++;
                                    continue;
                                }

                            }
                            else
                            {
                                fail++;
                                continue;
                            }

                        }
                        else
                        {
                            fail++;
                            continue;
                        }

                    }
                    else
                    {
                        fail++;
                        continue;
                    }
                    archives.setStatus("在库");
                    archives.setStorageTime(new Date()); // 记录入库时间
                    archivesDao.save(archives);
                }
                catch (Exception e)
                {
                    fail++;
                }
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        return result;
    }

    /**
     * 
     * 导入入库信息的时候判断是否能全部成功
     * 
     * @since 2011-1-18
     * @author shanru.wu
     * @param file
     * @param dstPath
     * @param succesStuNos
     *            (记录能正确导入的学生学号)
     * @param errorStuNos
     *            (记录错误导入的学生学号)
     * @param errorStr
     *            (记录错误原因)
     * @param notExistInfo
     *            (记录导入不存在的学生信息)
     * @return
     */
    public List<String> judge(File file, String dstPath,
            List<String> succesStuNos, List<String> errorStuNos,
            List<String> errorList, List<List<String>> notExistInfo)
    {

        File dstFile = new File(dstPath);
        ExcelUtils.copy(file, dstFile);
        List<String> keyList = new ArrayList<String>();

        String filetype = dstPath.substring(dstPath.lastIndexOf(".") + 1);

        List<Map<String, String>> datas = null;
        if (filetype.equalsIgnoreCase("xlsx"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, false);
            datas = ExcelUtils.excel2List(keyList, dstFile, false);
        }
        if (filetype.equalsIgnoreCase("xls"))
        {
            keyList = ExcelUtils.excelFirstRowColumn(file, true);
            datas = ExcelUtils.excel2List(keyList, dstFile, true);
        }
        List<String> result = new ArrayList<String>();
        int fail = 0;
        int total = 0;
        if (null != datas && datas.size() > 1)
        {
            total = datas.size() - 1;
            for (int i = 1; i < datas.size(); i++)
            {
                String stuId = ""; // 学号
                String storeInfo = ""; // 库位信息
                String name = ""; // 姓名
                String archivesInfo = ""; // 库位信息
                String transfer = ""; // 移交人
                String recipient = "";// 接收人
                String errorStr = "";

                try
                {
                    Map<String, String> data = datas.get(i);
                    for (int j = 0; j < keyList.size(); j++)
                    {
                        String key = keyList.get(j);
                        if (key.equals("学号"))
                        {
                            stuId = data.get(key);
                        }

                        if (key.equals("库位信息"))
                        {
                            storeInfo = data.get(key);
                        }
                        if (key.equals("档案信息"))
                        {
                            archivesInfo = data.get(key);
                        }
                        if (key.equals("移交人"))
                        {
                            transfer = data.get(key);
                        }
                        if (key.equals("接收人"))
                        {
                            recipient = data.get(key);
                        }
                        if (key.equals("姓名"))
                        {
                            name = data.get(key);
                        }

                    }
                    // 判断学生档案是否存在
                    if (archivesDao.isPropertyUnique("stuId", stuId, ""))
                    {

                        String tempName = studentWebService
                                .getNameByStuId(stuId);
                        if (null != tempName
                                && StringUtils.isNotEmpty(tempName))
                        { // 学生学号和姓名对应
                            if (tempName.equals(name))
                            {

                                // 判断学生档案信息的格式是否正确
                                if (StringUtils.isNotEmpty(storeInfo)
                                        && storeInfo.split("-").length != 4)
                                {
                                    errorStuNos.add(stuId);
                                    errorStr = "档案格式不正确";
                                    fail++;
                                }
                                else
                                {

                                    succesStuNos.add(stuId);
                                }

                            }
                            else
                            {

                                errorStuNos.add(stuId);
                                errorStr = "学号和姓名不对应";
                                fail++;
                            }

                        }
                        else
                        {
                            List<String> temp = new ArrayList<String>();
                            temp.add(stuId);
                            temp.add(name);
                            temp.add(archivesInfo);
                            temp.add(archivesInfo);
                            temp.add(transfer);
                            temp.add(recipient);
                            notExistInfo.add(temp);
                            errorStr = "不存在此学生，或者学号不对";
                            errorStuNos.add(stuId);
                            fail++;
                        }

                    }
                    else
                    {

                        errorStr = "该生档案已存在";
                        errorStuNos.add(stuId);
                        fail++;
                    }
                    if (StringUtils.isNotEmpty(errorStr) && errorStr != null)
                    {
                        errorList.add(errorStr);
                    }

                }
                catch (Exception e)
                {
                    fail++;
                }
            }
        }
        result.add(String.valueOf(total));
        result.add(String.valueOf(fail));
        return result;
    }

    @Autowired
    public void setArchivesDao(ArchivesDao archivesDao)
    {
        this.archivesDao = archivesDao;
    }

    @Autowired
    public void setDictionaryManager(DictionaryManager dictionaryManager)
    {
        this.dictionaryManager = dictionaryManager;
    }

    /**
     * {@inheritDoc}
     * 
     * @since 2010-12-17
     * @see cn.loosoft.springside.service.EntityManager#getEntityDao()
     */
    @Override
    protected HibernateDao<Archives, Long> getEntityDao()
    {
        // TODO Auto-generated method stub
        return archivesDao;
    }

    @Autowired
    public void setStudentWebService(StudentWebService studentWebService)
    {
        this.studentWebService = studentWebService;
    }

}
