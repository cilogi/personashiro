// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        IniAdmins.java  (10-Oct-2012)
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


package com.cilogi.shiro.guice;

import org.apache.shiro.realm.text.IniRealm;

import java.util.logging.Logger;

// find all the users which are admins from the ini realm
public class IniAdmins {
    static final Logger LOG = Logger.getLogger(IniAdmins.class.getName());

    private final IniRealm realm;

    public IniAdmins() {
        IniRealm realm = new IniRealm("classpath:shiro.ini");
        this.realm = realm;
    }

    public boolean isAdmin(String name) {
        return realm.accountExists(name);
    }
}
