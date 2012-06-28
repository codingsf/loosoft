package cn.loosoft.stuwork.workstudy.service.account;

/**
 * 
 * 查询结果不唯一异常
 * @author houbing.qian
 */
public class NotUniqueServiceException extends RuntimeException {

	private static final long serialVersionUID = 3583566093089790852L;

	public NotUniqueServiceException() {
		super();
	}

	public NotUniqueServiceException(String message) {
		super(message);
	}

	public NotUniqueServiceException(Throwable cause) {
		super(cause);
	}

	public NotUniqueServiceException(String message, Throwable cause) {
		super(message, cause);
	}
}
