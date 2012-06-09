/*
 * Copyright 2007 The JA-SIG Collaborative. All rights reserved. See license
 * distributed with this file and available online at
 * http://www.ja-sig.org/products/cas/overview/license/
 */
package org.jasig.cas.web.view;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;

import org.jasig.cas.authentication.Authentication;
import org.jasig.cas.authentication.SamlAuthenticationMetaDataPopulator;
import org.jasig.cas.authentication.principal.SamlService;
import org.jasig.cas.authentication.principal.Service;
import org.jasig.cas.validation.Assertion;
import org.opensaml.SAMLAssertion;
import org.opensaml.SAMLAttribute;
import org.opensaml.SAMLAttributeStatement;
import org.opensaml.SAMLAudienceRestrictionCondition;
import org.opensaml.SAMLAuthenticationStatement;
import org.opensaml.SAMLException;
import org.opensaml.SAMLNameIdentifier;
import org.opensaml.SAMLResponse;
import org.opensaml.SAMLSubject;

/**
 * Implementation of a view to return a SAML response and assertion, based on
 * the SAML 1.1 specification.
 * <p>
 * If an AttributePrincipal is supplied, then the assertion will include the
 * attributes from it (assuming a String key/Object value pair). The only
 * Authentication attribute it will look at is the authMethod (if supplied).
 * <p>
 * Note that this class will currently not handle proxy authentication.
 * <p>
 * Note: This class currently expects a bean called "ServiceRegistry" to exist.
 * 
 * @author Scott Battaglia
 * @version $Revision: 21756 $ $Date: 2010-09-25 12:42:56 -0400 (Sat, 25 Sep 2010) $
 * @since 3.1
 */
public class Saml10SuccessResponseView extends AbstractCasView {

    /** Namespace for custom attributes. */
    private static final String NAMESPACE = "http://www.ja-sig.org/products/cas/";

    private static final String DEFAULT_ENCODING = "UTF-8";

    /** The issuer, generally the hostname. */
    @NotNull
    private String issuer;

    /** The amount of time in milliseconds this is valid for. */
    private long issueLength = 30000;

    @NotNull
    private String encoding = DEFAULT_ENCODING;

    @Override
    protected void renderMergedOutputModel(final Map model,
        final HttpServletRequest request, final HttpServletResponse response) throws Exception {

        try {
            final Assertion assertion = getAssertionFrom(model);
            final Authentication authentication = assertion.getChainedAuthentications().get(0);
            final Date currentDate = new Date();
            final String authenticationMethod = (String) authentication.getAttributes().get(SamlAuthenticationMetaDataPopulator.ATTRIBUTE_AUTHENTICATION_METHOD);
            final Service service = assertion.getService();
            final SAMLResponse samlResponse = new SAMLResponse(null, service.getId(), new ArrayList<Object>(), null);

            samlResponse.setIssueInstant(currentDate);

            // this should be true, but we never enforced it, so we need to check to be safe
            if (service instanceof SamlService) {
                final SamlService samlService = (SamlService) service;

                if (samlService.getRequestID() != null) {
                    samlResponse.setInResponseTo(samlService.getRequestID());
                }
            }

            final SAMLAssertion samlAssertion = new SAMLAssertion();
            samlAssertion.setIssueInstant(currentDate);
            samlAssertion.setIssuer(this.issuer);
            samlAssertion.setNotBefore(currentDate);
            samlAssertion.setNotOnOrAfter(new Date(currentDate.getTime()
                + this.issueLength));

            final SAMLAudienceRestrictionCondition samlAudienceRestrictionCondition = new SAMLAudienceRestrictionCondition();
            samlAudienceRestrictionCondition.addAudience(service.getId());

            final SAMLAuthenticationStatement samlAuthenticationStatement = new SAMLAuthenticationStatement();
            samlAuthenticationStatement.setAuthInstant(authentication
                .getAuthenticatedDate());
            samlAuthenticationStatement
                .setAuthMethod(authenticationMethod != null
                    ? authenticationMethod
                    : SAMLAuthenticationStatement.AuthenticationMethod_Unspecified);

            samlAuthenticationStatement
                .setSubject(getSamlSubject(authentication));

            if (!authentication.getPrincipal().getAttributes().isEmpty()) {
                final SAMLAttributeStatement attributeStatement = new SAMLAttributeStatement();
    
                attributeStatement.setSubject(getSamlSubject(authentication));
                samlAssertion.addStatement(attributeStatement);

                for (final Entry<String, Object> e : authentication.getPrincipal().getAttributes().entrySet()) {
                    final SAMLAttribute attribute = new SAMLAttribute();
                    attribute.setName(e.getKey());
                    attribute.setNamespace(NAMESPACE);

                    if (e.getValue() instanceof Collection<?>) {
                        final Collection<?> c = (Collection<?>) e.getValue();
                        if (c.isEmpty()) {
                            // 100323 bnoordhuis: don't add the attribute, it causes a org.opensaml.MalformedException
                            continue;
                        }
                        attribute.setValues(c);
                    } else {
                        attribute.addValue(e.getValue());
                    }
    
                    attributeStatement.addAttribute(attribute);
                }
            }

            samlAssertion.addStatement(samlAuthenticationStatement);
            samlAssertion.addCondition(samlAudienceRestrictionCondition);
            samlResponse.addAssertion(samlAssertion);

            final String xmlResponse = samlResponse.toString();

            response.setContentType("text/xml; charset=" + this.encoding);
            response.getWriter().print("<?xml version=\"1.0\" encoding=\"" + this.encoding + "\"?>");
            response.getWriter().print("<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP-ENV:Header/><SOAP-ENV:Body>");
            response.getWriter().print(xmlResponse);
            response.getWriter().print("</SOAP-ENV:Body></SOAP-ENV:Envelope>");
            response.flushBuffer();
        } catch (final Exception e) {
            log.error(e.getMessage(), e);
            throw e;
        }
    }

    protected SAMLSubject getSamlSubject(final Authentication authentication)
        throws SAMLException {
        final SAMLSubject samlSubject = new SAMLSubject();
        samlSubject.addConfirmationMethod(SAMLSubject.CONF_ARTIFACT);
        final SAMLNameIdentifier samlNameIdentifier = new SAMLNameIdentifier();
        samlNameIdentifier.setName(authentication.getPrincipal().getId());

        samlSubject.setNameIdentifier(samlNameIdentifier);

        return samlSubject;
    }

    public void setIssueLength(final long issueLength) {
        this.issueLength = issueLength;
    }

    public void setIssuer(final String issuer) {
        this.issuer = issuer;
    }

    public void setEncoding(final String encoding) {
        this.encoding = encoding;
    }
}
