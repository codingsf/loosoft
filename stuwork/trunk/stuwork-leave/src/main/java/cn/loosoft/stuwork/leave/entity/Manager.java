package cn.loosoft.stuwork.leave.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import cn.loosoft.stuwork.common.entity.IdEntity;

/**
 * 
 * 管理员 权限关系
 * 
 * @author chenbo
 * @version 1.0
 * @since 2012-06-09
 */
@Entity
@Table(name = "manager")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Manager extends IdEntity {

	/**
	 * 
	 * enable 允许审批
	 */
	public static final int STATUS_ENABLE=1;
	/**
	 * disable 禁止审批
	 */
	public static final int STATUS_DISABLE=0;
	private String username;// 用户名
	private int status;// 用户权限 能否审批
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}


}
