// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        LoginServlet.java  (31-Oct-2011)
// Author:      tim

//
// Copyright in the whole and every part of this source file belongs to
// Tim Niblett (the Author) and may not be used,
// sold, licenced, transferred, copied or reproduced in whole or in
// part in any manner or form or in or on any media to any person
// other than in accordance with the terms of The Author's agreement
// or otherwise without the prior written consent of The Author.  All
// information contained in this source file is confidential information
// belonging to The Author and as such may not be disclosed other
// than in accordance with the terms of The Author's agreement, or
// otherwise, without the prior written consent of The Author.  As
// confidential information this source file must be kept fully and
// effectively secure at all times.
//


package com.cilogi.shiro.web;

import com.cilogi.shiro.gae.UserDAO;
import com.cilogi.shiro.persona.PersonaAuthenticationToken;
import com.cilogi.shiro.persona.PersonaLogin;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;

import javax.inject.Inject;
import javax.inject.Named;
import javax.inject.Provider;
import javax.inject.Singleton;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Singleton
public class LoginServlet extends BaseServlet {

    private final String host;
    private final PersonaLogin personaLogin;

    @Inject
    LoginServlet(Provider<UserDAO> userDAOProvider, PersonaLogin personaLogin, @Named("host") String host) {
        super(userDAOProvider);
        this.personaLogin = personaLogin;
        this.host = host;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showView(response, "login.ftl");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String token = WebUtils.getCleanParam(request, TOKEN);
            boolean rememberMe = WebUtils.isTrue(request, REMEMBER_ME);

            PersonaAuthenticationToken personaToken = new PersonaAuthenticationToken(token, host, rememberMe);
            try {
                personaLogin.login(personaToken);
                SavedRequest savedRequest = WebUtils.getAndClearSavedRequest(request);
                String redirectUrl = (savedRequest == null) ? "/index.html" : savedRequest.getRequestUrl();
                response.sendRedirect(response.encodeRedirectURL(redirectUrl));
            } catch (AuthenticationException e) {
                issue(MIME_TEXT_PLAIN, HTTP_STATUS_NOT_FOUND, "cannot authorize token: " + token, response);
            }
        } catch (Exception e) {
            issue(MIME_TEXT_PLAIN, HTTP_STATUS_INTERNAL_SERVER_ERROR, "Internal error: " + e.getMessage(), response);
        }
    }
}
