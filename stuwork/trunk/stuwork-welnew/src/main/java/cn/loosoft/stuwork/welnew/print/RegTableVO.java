package cn.loosoft.stuwork.welnew.print;
/**
 * 报到表print vo
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2011-9-05
 */
public class RegTableVO {

    private String collegeName;//学院名称
    private String majorName;  //专业名称

    private String regOperator;    //注册经办人

    private String name;       //姓名

    private String roombed;    //宿舍

    private String year;    //报到年份
    private String month;    //报到年份
    private String day;    //报到年份

    public String getCollegeName()
    {
        return collegeName;
    }


    public void setCollegeName(String collegeName)
    {
        this.collegeName = collegeName;
    }


    public String getMajorName()
    {
        return majorName;
    }


    public void setMajorName(String majorName)
    {
        this.majorName = majorName;
    }


    public String getName()
    {
        return name;
    }


    public void setName(String name)
    {
        this.name = name;
    }


    public String getRoombed()
    {
        return roombed;
    }


    public void setRoombed(String roombed)
    {
        this.roombed = roombed;
    }


    public String getYear()
    {
        return year;
    }


    public void setYear(String year)
    {
        this.year = year;
    }


    public String getMonth()
    {
        return month;
    }


    public void setMonth(String month)
    {
        this.month = month;
    }


    public String getDay()
    {
        return day;
    }


    public void setDay(String day)
    {
        this.day = day;
    }


    public String getRegOperator()
    {
        return regOperator;
    }


    public void setRegOperator(String regOperator)
    {
        this.regOperator = regOperator;
    }

}
