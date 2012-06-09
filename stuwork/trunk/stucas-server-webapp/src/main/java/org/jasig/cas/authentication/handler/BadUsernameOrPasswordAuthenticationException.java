/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.authentication.handler;

/**
 * Exception to throw when we know the credentials provided were
 * username/password and the combination is wrong.
 * 
 * @author Scott Battaglia
 * @version $Revision: 14064 $ $Date: 2007-06-10 09:17:55 -0400 (Sun, 10 Jun 2007) $
 * @since 3.0
 */
public class BadUsernameOrPasswordAuthenticationException extends
    BadCredentialsAuthenticationException {

    /** Static instance of BadUsernameOrPasswordAuthenticationException. */
    public static final BadUsernameOrPasswordAuthenticationException ERROR = new BadUsernameOrPasswordAuthenticationException();

    /** Unique ID for serializing. */
    private static final long serialVersionUID = 3977861752513837361L;

    /** The default code for this exception used for message resolving. */
    private static final String CODE = "error.authentication.credentials.bad.usernameorpassword";

    /**
     * Default constructor that does not allow the chaining of exceptions and
     * uses the default code as the error code for this exception.
     */
    public BadUsernameOrPasswordAuthenticationException() {
        super(CODE);
    }

    /**
     * Constructor that allows for the chaining of exceptions. Defaults to the
     * default code provided for this exception.
     * 
     * @param throwable the chained exception.
     */
    public BadUsernameOrPasswordAuthenticationException(
        final Throwable throwable) {
        super(CODE, throwable);
    }

    /**
     * Constructor that allows for providing a custom error code for this class.
     * Error codes are often used to resolve exceptions into messages. Providing
     * a custom error code allows the use of a different message.
     * 
     * @param code the custom code to use with this exception.
     */
    public BadUsernameOrPasswordAuthenticationException(final String code) {
        super(code);
    }

    /**
     * Constructor that allows for chaining of exceptions and a custom error
     * code.
     * 
     * @param code the custom error code to use in message resolving.
     * @param throwable the chained exception.
     */
    public BadUsernameOrPasswordAuthenticationException(final String code,
        final Throwable throwable) {
        super(code, throwable);
    }
}
