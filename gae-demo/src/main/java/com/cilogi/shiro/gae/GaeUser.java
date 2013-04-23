// Copyright (c) 2011 Tim Niblett All Rights Reserved.
//
// File:        GaeUser.java  (26-Oct-2011)
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


package com.cilogi.shiro.gae;

import com.cilogi.shiro.persona.IPersonaUser;
import com.google.common.base.Preconditions;
import com.google.common.collect.Sets;
import com.googlecode.objectify.annotation.*;

import java.io.Serializable;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Cache
@Entity
/**
 * Minimal user to be stored by AppEngine data store.  Serializable
 * so that we can use instances in sessions.
 */
public class GaeUser implements Serializable, IPersonaUser {

    @Id
    private String emailAddress;

    @Serialize
    private Set<String> roles;

    @Serialize
    private Set<String> permissions;

    @Index
    private Date dateRegistered;

    // this seems to be useful, as the only alternative would be to delete a user,
    // which would lose all their information...
    private boolean isSuspended;

    /** For objectify to create instances on retrieval */
    private GaeUser() {
        this.roles = new HashSet<String>();
        this.permissions = new HashSet<String>();
    }
    
    GaeUser(String emailAddress) {
        this(emailAddress, Sets.newHashSet("user"), Sets.<String>newHashSet());
    }

    public GaeUser(String emailAddress, Set<String> roles, Set<String> permissions) {
        Preconditions.checkNotNull(emailAddress, "User email  can't be null");
        Preconditions.checkNotNull(roles, "User roles can't be null");
        Preconditions.checkNotNull(permissions, "User permissions can't be null");
        this.emailAddress = emailAddress;

        this.roles = roles;
        this.permissions = permissions;
        this.dateRegistered = new Date();
        this.isSuspended = false;
    }

    public boolean isSuspended() {
        return isSuspended;
    }

    public void setSuspended(boolean suspended) {
        isSuspended = suspended;
    }

    public Date getDateRegistered() {
        return dateRegistered;
    }

    @Override
    public String getEmailAddress() {
        return emailAddress;
    }

    @Override
    public synchronized Set<String> getRoles() {
        return Collections.unmodifiableSet(roles);
    }

    public synchronized void setRoles(Set<String> roles) {
        this.roles.clear();
        this.roles.addAll(roles);
    }

    @Override
    public synchronized Set<String> getPermissions() {
        return Collections.unmodifiableSet(permissions);
    }

    public synchronized void setPermissions(Set<String> roles) {
        this.permissions.clear();
        this.permissions.addAll(roles);
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof GaeUser) {
            GaeUser u = (GaeUser)o;
            return getEmailAddress().equals(u.getEmailAddress());
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return emailAddress.hashCode();
    }
}
