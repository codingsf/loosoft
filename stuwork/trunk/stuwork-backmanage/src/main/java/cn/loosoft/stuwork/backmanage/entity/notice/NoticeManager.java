package cn.loosoft.stuwork.backmanage.entity.notice;

import java.security.Identity;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

@Entity
//表名与类名不相同时重新定义表名.
@Table(name = "NoticeManager")
//默认的缓存策略.
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class NoticeManager extends IdEntity {
private int noticeYear;
public int getNoticeYear() {
	return noticeYear;
}
public void setNoticeYear(int noticeYear) {
	this.noticeYear = noticeYear;
}
public String getNoticeMark() {
	return noticeMark;
}
public void setNoticeMark(String noticeMark) {
	this.noticeMark = noticeMark;
}
public String getNoticeUrl() {
	return noticeUrl;
}
public void setNoticeUrl(String noticeUrl) {
	this.noticeUrl = noticeUrl;
}
public boolean isNoticeIsUse() {
	return noticeIsUse;
}
public void setNoticeIsUse(boolean noticeIsUse) {
	this.noticeIsUse = noticeIsUse;
}
public String getNoticeType() {
	return noticeType;
}
public void setNoticeType(String noticeType) {
	this.noticeType = noticeType;
}
private String noticeMark;
private String noticeUrl;
private boolean noticeIsUse;
private String noticeType;
}
