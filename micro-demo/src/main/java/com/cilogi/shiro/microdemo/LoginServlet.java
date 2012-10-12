// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        LoginServlet.java  (11-Oct-2012)
// Author:      tim
//
// Copyright in the whole and every part of this source file belongs to
// Tim Niblett (the Author) and may not be used, sold, licenced, 
// transferred, copied or reproduced in whole or in part in 
// any manner or form or in or on any media to any person other than 
// in accordance with the terms of The Author's agreement
// or otherwise without the prior written consent of The Author.  All
// information contained in this source file is confidential information
// belonging to The Author and as such may not be disclosed other
// than in accordance with the terms of The Author's agreement, or
// otherwise, without the prior written consent of The Author.  As
// confidential information this source file must be kept fully and
// effectively secure at all times.
//


package com.cilogi.shiro.microdemo;

import com.cilogi.shiro.persona.DefaultPersonaUserDAO;
import com.cilogi.shiro.persona.PersonaAuthenticationToken;
import com.cilogi.shiro.persona.PersonaLogin;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.nio.charset.Charset;

public class LoginServlet extends HttpServlet {

    private final PersonaLogin personaLogin;

    public LoginServlet() {
        personaLogin = new PersonaLogin(new DefaultPersonaUserDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        out.println(loadStringUTF8(getClass().getResource("/login.jsp")));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String token = WebUtils.getCleanParam(request, "token");

            PersonaAuthenticationToken personaToken = new PersonaAuthenticationToken(token, "http://localhost:8080", true);
            try {
                personaLogin.login(personaToken);
                SavedRequest savedRequest = WebUtils.getAndClearSavedRequest(request);
                String redirectUrl = (savedRequest == null) ? null : savedRequest.getRequestUrl();
                if (redirectUrl != null) {
                    response.sendRedirect(response.encodeRedirectURL(redirectUrl));
                }  else {
                    issue("text/plain", HttpServletResponse.SC_OK, JSPAssist.getCurrentUser(), response);
                }
            } catch (AuthenticationException e) {
                issue("text/plain", HttpServletResponse.SC_NOT_FOUND, "cannot authorize token: " + token, response);
            }
        } catch (Exception e) {
            issue("text/plain", HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal error: " + e.getMessage(), response);
        }
    }

    private void issue(String mimeType, int returnCode, String output, HttpServletResponse response) throws IOException {
        response.setContentType(mimeType);
        response.setStatus(returnCode);
        response.getWriter().println(output);
    }


    private static String loadStringUTF8(URL url) throws IOException {
        return new String(loadBytes(url), Charset.forName("utf-8"));
    }

    private static byte[] loadBytes(URL url) throws IOException {
        InputStream is = url.openStream();
        try {
            return copyStream(is);
        } finally {
            is.close();
        }
    }
    
    private static byte[] copyStream(InputStream in) throws IOException {
        final int BUFSZ = 4096;
        ByteArrayOutputStream out = new ByteArrayOutputStream(BUFSZ * 20);
        byte[] buf = new byte[BUFSZ];
        int nRead;
        while ((nRead = in.read(buf)) != -1) {
            out.write(buf, 0, nRead);
        }
        out.flush();
        byte[] ret = out.toByteArray();
        out.close();
        return ret;
    }

}
