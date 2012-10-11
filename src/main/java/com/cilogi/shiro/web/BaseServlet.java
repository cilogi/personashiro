// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        BaseServlet.java  (31-Oct-2011)
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

import com.google.common.base.Preconditions;
import org.json.JSONException;
import org.json.JSONObject;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


class BaseServlet extends HttpServlet {

    protected static final String MESSAGE = "message";

    protected final String MIME_TEXT_PLAIN = "text/plain";
    protected final String MIME_TEXT_HTML = "text/html";
    protected final String MIME_APPLICATION_JSON = "application/json";

    protected final int HTTP_STATUS_OK = HttpServletResponse.SC_OK;
    protected final int HTTP_STATUS_NOT_FOUND = HttpServletResponse.SC_NOT_FOUND;
    protected final int HTTP_STATUS_INTERNAL_SERVER_ERROR = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;

    BaseServlet() {}

    protected void issue(String mimeType, int returnCode, String output, HttpServletResponse response) throws IOException {
        response.setContentType(mimeType);
        response.setStatus(returnCode);
        response.getWriter().println(output);
    }

    protected void issueJson(HttpServletResponse response, int status, String... args) throws IOException {
        Preconditions.checkArgument(args.length % 2 == 0, "There must be an even number of strings");
            try {
            JSONObject obj = new JSONObject();
            for (int i = 0; i < args.length; i += 2) {
                obj.put(args[i], args[i+1]);
            }
            issueJson(response, status, obj);
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }

    protected void issueJson(HttpServletResponse response, int status, JSONObject obj) throws IOException {
        issue(MIME_APPLICATION_JSON, status, obj.toString(), response);
    }

    protected int intParameter(String name, HttpServletRequest request, int deflt) {
        String s = request.getParameter(name);
        return (s == null) ? deflt : Integer.parseInt(s);
    }
}
