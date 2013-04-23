// Copyright (c) 2013 Cilogi. All Rights Reserved.
//
// File:        DefaultPersonaUser.java  (23/04/13)
// Author:      tim
//
// Copyright in the whole and every part of this source file belongs to
// Cilogi (the Author) and may not be used, sold, licenced, 
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


package com.cilogi.shiro.persona;

import com.google.common.collect.Sets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Set;


public class DefaultPersonaUser implements IPersonaUser {
    static final Logger LOG = LoggerFactory.getLogger(DefaultPersonaUser.class);

    private String emailAddress;
    private Set<String> roles;
    private Set<String> permissions;

    public DefaultPersonaUser(String emailAddress, Set<String> roles, Set<String> permissions) {
        this.emailAddress = emailAddress;
        this.roles = roles;
        this.permissions = permissions;
    }

    @Override
    public String getEmailAddress() {
        return emailAddress;
    }

    @Override
    public Set<String> getRoles() {
        return roles;
    }

    @Override
    public Set<String> getPermissions() {
        return permissions;
    }

}
