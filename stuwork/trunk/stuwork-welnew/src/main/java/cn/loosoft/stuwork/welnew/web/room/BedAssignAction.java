package cn.loosoft.stuwork.welnew.web.room;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;

import cn.common.lib.util.web.ParamUtils;
import cn.loosoft.common.vo.LabelValue;
import cn.loosoft.stuwork.welnew.entity.batch.Welbatch;
import cn.loosoft.stuwork.welnew.entity.room.Bed;
import cn.loosoft.stuwork.welnew.entity.student.Student;
import cn.loosoft.stuwork.welnew.service.batch.WelbatchManager;
import cn.loosoft.stuwork.welnew.service.room.BedManager;
import cn.loosoft.stuwork.welnew.service.student.StudentManager;
import cn.loosoft.stuwork.welnew.vo.RoomVO;

import com.google.common.collect.Lists;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * 床位分配Action.
 * 
 * @author houbing.qian
 * @author shanru.wu
 * @version 1.0
 * @since 2010-8-24
 */
@Namespace("/room")
@ParentPackage("json-default")
@Results( { @Result(name = "assign", location = "bed-assign.jsp"),
    @Result(name = "select", location = "bed-select.jsp") ,@Result(name = "ajaxbed",type = "json")})
    public class BedAssignAction extends ActionSupport
    {
    private static final long serialVersionUID = 1L;

    private BedManager        bedManager;           // 床位信息

    private StudentManager    studentManager;       // 学生信息

    private WelbatchManager   welbatchManager;      // 入学批次

    // -- 页面属性 --//
    private String            examineeNo;           // 考生号

    private String            IDcard;               // 身份证号

    private String            assignResult;         // 分配结果

    List<RoomVO>              roomList;             // 寝室列表

    private Long              countBed;             // 床位总数

    private Long              unassignBed;          // 未分床位总数

    private String            collegeName;          // 院系名称

    private String            majorName;            // 专业名称

    private String            className;            // 班级名称

    private String            validResult;          // 验证结果

    private Student student;//被分配的学生

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public Student getStudent()
    {
        return student;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    // -- CRUD Action 函数 --//
    /**
     * 加载分配页面 保留方法
     */
    public String loadPage()
    {
        return "assign";
    }

    // -- other Action 函数 --//
    /**
     * 自动分配床位
     */

    public String autoAssign()
    {
        // get current welcom batch
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        if (welbatch == null)
        {
            assignResult = "请先设置当前入学批次";
            return "assign";
        }

        // get student
        student = studentManager.getByExamineeNo(examineeNo, welbatch);
        if (student == null)
        {
            student = studentManager.getByIdCardNo(IDcard, welbatch);
        }
        if (student == null)
        {
            assignResult = "该新生不存在，确认输入或者检查新生名单是否导入系统";
            return "assign";
        }
        if (StringUtils.isNotEmpty(student.getRoombed()))
        {
            assignResult = "该新生已经分配了宿舍";
            return "assign";
        }

        // get valid bed info
        Bed bed = bedManager.getUnassignedBed(student.getCollegeCode(), student
                .getMajorCode(), student.getClassCode());
        if (bed == null)
        {
            assignResult = "系统已经没有可分配的床位，请与宿管科联系，新增预分床位";
            return "assign";
        }
        // 下面两步稍候要放到一个事务中
        // assign bed
        String roombed = (bed.getBuilding().indexOf("楼")) > 0 ? bed
                .getBuilding() : bed.getBuilding()
                + "楼"
                + (bed.getFloor().indexOf("层") > 0 ? bed.getFloor() : bed
                        .getFloor()
                        + "层")
                        + (bed.getRoom().indexOf("室") > 0 ? bed.getRoom() : bed
                                .getRoom()
                                + "室");
                student.setRoombed(roombed);
                studentManager.save(student);
                // update bed status
                bed.setAssigned(true);
                bed.setStudent(student);
                bedManager.save(bed);

                assignResult = "分配到 " + roombed;
                return "assign";
    }

    /**
     * 
     * 选择床位，手工分配
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @return
     */
    public String select()
    {
        // get current welcom batch
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        if (welbatch == null)
        {
            addActionMessage("请先设置当前入学批次");
            return "select";
        }
        // get student
        student = studentManager.getByExamineeNo(examineeNo, welbatch);
        if (student == null)
        {
            student = studentManager.getByIdCardNo(IDcard, welbatch);
        }
        if (student == null)
        {
            assignResult = "该新生不存在，确认输入或者检查新生名单是否导入系统";
            return "assign";
        }

        // get countBed
        this.countBed = bedManager.countBed(student.getCollegeCode(), student
                .getMajorCode(), student.getClassCode());
        this.unassignBed = bedManager.unassignBed(student.getCollegeCode(),
                student.getMajorCode(), student.getClassCode(), 0);
        this.collegeName = student.getCollegeName();
        this.majorName = student.getMajorName();
        this.className = student.getClassName();

        if (StringUtils.isNotEmpty(student.getRoombed()))
        {
            addActionMessage("该新生已经分配了宿舍");
            return "select";
        }

        // Boolean isAssigned = Boolean.FALSE;
        int isAssigned = 0;
        List<Bed> unassignedBeds = bedManager.getBeds(student.getCollegeCode(),
                student.getMajorCode(), student.getClassCode(), isAssigned);

        // 将床位列表处理成寝室VO列表,用于在列表显示
        roomList = convertToRoomVOList(unassignedBeds);
        return "select";
    }

    /**
     * 验证床位
     * ajax调用
     * @since  2011-9-2
     * @author houbing.qian
     */
    public String validBed(){
        // get current welcom batch
        Welbatch welbatch = welbatchManager.getCurrentBatch();
        if (welbatch == null)
        {
            validResult = "no";
            return "ajaxbed";
        }

        // get student
        student = studentManager.getByExamineeNo(examineeNo, welbatch);
        // get valid bed info
        Bed bed = bedManager.getUnassignedBed(student.getCollegeCode(), student
                .getMajorCode(), student.getClassCode());
        if(!StringUtils.isEmpty(student.getRoombed())){
            validResult = "has";
        }else if (StringUtils.isEmpty(student.getRoombed()) && bed == null)
        {
            validResult = "no";
        }
        else
        {
            validResult = "yes";
        }
        return "ajaxbed";
    }

    /**
     * 选择学生，进行手工床位分配
     * ajax调用
     * @since 2010-11-28
     * @author shanru.wu
     * @return
     */
    public String handAssign()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        Welbatch welbatch = welbatchManager.getCurrentBatch();

        student = studentManager.getByExamineeNo(examineeNo, welbatch);
        String roombed = ParamUtils.getParameter(request, "zdroom","");
        //如果有指定手工房间直接分配即可
        if(roombed.equals("")){
            Long bedID = Long.parseLong(request.getParameter("bedID").toString());
            Bed bed = bedManager.get(bedID);

            // 下面两步稍候要放到一个事务中
            // assign bed
            roombed = (bed.getBuilding().indexOf("楼")) > 0 ? bed
                    .getBuilding() : bed.getBuilding()
                    + "楼"
                    + (bed.getFloor().indexOf("层") > 0 ? bed.getFloor() : bed
                            .getFloor()
                            + "层")
                            + (bed.getRoom().indexOf("室") > 0 ? bed.getRoom() : bed
                                    .getRoom()
                                    + "室");
                    // update bed status
                    bed.setAssigned(true);
                    bed.setStudent(student);    

                    bedManager.save(bed);
        }
        student.setRoombed(roombed);
        studentManager.save(student);

        assignResult = "分配到 " + roombed;
        return "ajaxbed";
    }

    /**
     * 
     * 将床位列表处理成寝室VO列表
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @param unassignedBeds
     * @return
     */
    private List<RoomVO> convertToRoomVOList(List<Bed> unassignedBeds)
    {
        RoomVO roomVO = null;
        List<RoomVO> roomVOList = Lists.newArrayList();
        String room = "";
        List<LabelValue> bedList = null;
        for (Bed bed : unassignedBeds)
        {
            if (!room.equals(bed.getRoom()))
            {
                room = bed.getRoom();
                roomVO = new RoomVO();
                roomVO.setBuilding(bed.getBuilding());
                roomVO.setFloor(bed.getFloor());
                roomVO.setRoom(bed.getRoom());
                roomVOList.add(roomVO);
                bedList = Lists.newArrayList();
                roomVO.setBeds(bedList);
            }
            bedList.add(new LabelValue(String.valueOf(bed.getId()), bed
                    .getBedNo()));
        }
        return roomVOList;
    }


    // -- 页面属性访问函数 --//

    /**
     * 页面取得分配结果
     */
    @JSON(name = "assignResult")    
    public String getAssignResult()
    {
        return assignResult;
    }


    @JSON(name = "validResult")
    public String getValidResult()
    {
        return validResult;
    }

    /**
     * 
     * 页面显示用的寝室列表数据
     * 
     * @since 2010-8-24
     * @author houbing.qian
     * @return
     */
    public List<RoomVO> getRoomList()
    {
        return roomList;
    }

    /**
     * 
     * 获取所有的床位信息.
     * 
     * @since 2010-12-2
     * @author shanru.wu
     * @return
     */
    public Long getCountBed()
    {
        return countBed;
    }

    public String getCollegeName()
    {
        if (StringUtils.isNotEmpty(collegeName))
        {
            if (this.collegeName.indexOf("学院") > 0)
            {
                return this.collegeName;
            }
            else
            {
                return this.collegeName + "学院";
            }
        }
        else
        {
            return "";
        }
    }

    public String getMajorName()
    {
        if (StringUtils.isNotEmpty(majorName))
        {
            if (this.majorName.indexOf("专业") > 0)
            {
                return this.majorName;
            }
            else
            {
                return this.majorName + "专业";
            }
        }
        else
        {
            return "";
        }
    }

    public String getClassName()
    {
        if (StringUtils.isNotEmpty(className))
        {
            if (this.className.indexOf("班") > 0)
            {
                return this.className;
            }
            else
            {
                return this.className + "班";
            }
        }
        else
        {
            return "";
        }
    }

    public Long getUnassignBed()
    {
        return unassignBed;
    }

    @Autowired
    public void setBedManager(BedManager bedManager)
    {
        this.bedManager = bedManager;
    }

    @Autowired
    public void setStudentManager(StudentManager studentManager)
    {
        this.studentManager = studentManager;
    }

    @Autowired
    public void setWelbatchManager(WelbatchManager welbatchManager)
    {
        this.welbatchManager = welbatchManager;
    }

    }