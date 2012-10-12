// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        JSPAssist.java  (12-Oct-2012)
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

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;


public class JSPAssist {

    private JSPAssist() {}

    public static String getCurrentUser() {
        Subject subject = SecurityUtils.getSubject();
        String principal = (String)subject.getPrincipal();
        return (principal == null) ? "" : principal;
    }

    public static String getLoginClass() {
        Subject subject = SecurityUtils.getSubject();
        boolean isLoggedIn = subject.isRemembered() || subject.isAuthenticated();
        return isLoggedIn ? "logged-in" : "logged-out";
    }
}
