package cn.loosoft.stuwork.welnew.print;
/**
 * 通知书打印vo
 * Description of the class
 *
 * @author            houbing.qian
 * @version           1.0
 * @since             2011-7-27
 */
public class NoticeCertVO {

    private String leftName;//姓名
    private String rightName;//姓名

    private String leftContent;//左边内容

    private String rightContent;//右边内容

    private String examineeNo;//考生号

    private String length;//学制

    public String getLength()
    {
        return length;
    }

    public void setLength(String length)
    {
        this.length = length;
    }

    private String IDcard;//身份证号

    private String noticeId;//通知书编号

    private String time;//录取时间

    private String tiaoma;//条码

    public String getTiaoma()
    {
        return tiaoma;
    }

    public void setTiaoma(String tiaoma)
    {
        this.tiaoma = tiaoma;
    }


    public String getLeftName()
    {
        return leftName;
    }

    public void setLeftName(String leftName)
    {
        this.leftName = leftName;
    }

    public String getRightName()
    {
        return rightName;
    }

    public void setRightName(String rightName)
    {
        this.rightName = rightName;
    }

    public String getLeftContent()
    {
        return leftContent;
    }

    public void setLeftContent(String leftContent)
    {
        this.leftContent = leftContent;
    }

    public String getRightContent()
    {
        return rightContent;
    }

    public void setRightContent(String rightContent)
    {
        this.rightContent = rightContent;
    }

    public String getExamineeNo()
    {
        return examineeNo;
    }

    public void setExamineeNo(String examineeNo)
    {
        this.examineeNo = examineeNo;
    }

    public String getIDcard()
    {
        return IDcard;
    }

    public void setIDcard(String iDcard)
    {
        IDcard = iDcard;
    }

    public String getNoticeId()
    {
        return noticeId;
    }

    public void setNoticeId(String noticeId)
    {
        this.noticeId = noticeId;
    }

    public String getTime()
    {
        return time;
    }

    public void setTime(String time)
    {
        this.time = time;
    }

}
