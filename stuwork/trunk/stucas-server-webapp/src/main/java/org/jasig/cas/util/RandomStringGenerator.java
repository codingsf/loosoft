/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.util;

/**
 * Interface to return a random String.
 * 
 * @author Scott Battaglia
 * @version $Revision: 14234 $ $Date: 2007-07-10 11:41:31 -0400 (Tue, 10 Jul 2007) $
 * @since 3.0
 */
public interface RandomStringGenerator {

    /**
     * @return the minimum length as an int guaranteed by this generator.
     */
    int getMinLength();

    /**
     * @return the maximum length as an int guaranteed by this generator.
     */
    int getMaxLength();

    /**
     * @return the new random string
     */
    String getNewString();
    
    byte[] getNewStringAsBytes();
}
