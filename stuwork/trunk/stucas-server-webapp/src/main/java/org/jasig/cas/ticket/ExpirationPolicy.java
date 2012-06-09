/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.ticket;

import java.io.Serializable;

/**
 * Strategy that determines if the ticket is expired. Implementations of the
 * Expiration Policy define their own rules on what they consider an expired
 * Ticket to be.
 * 
 * @author Scott Battaglia
 * @version $Revision: 14064 $ $Date: 2007-06-10 09:17:55 -0400 (Sun, 10 Jun 2007) $
 * @since 3.0
 * <p>
 * This is a published and supported CAS Server 3 API.
 * </p>
 * @see org.jasig.cas.ticket.Ticket
 */
public interface ExpirationPolicy extends Serializable {

    /**
     * Method to determine if a Ticket has expired or not, based on the policy.
     * 
     * @param ticketState The snapshot of the current ticket state
     * @return true if the ticket is expired, false otherwise.
     */
    boolean isExpired(TicketState ticketState);
}
