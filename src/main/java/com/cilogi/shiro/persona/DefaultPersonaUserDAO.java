// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        DefaultPersonaUserDAO.java  (11-Oct-2012)
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


package com.cilogi.shiro.persona;

import java.util.HashSet;
import java.util.Set;

/**
 *
 * Use this if you don't store users in a database.
 */
public class DefaultPersonaUserDAO implements IPersonaUserDAO {

    public DefaultPersonaUserDAO() {

    }

    public void newUserIfNotExists(String principal) {
        // do nothing
    }

    public boolean isUserExistsAndInGoodStanding(String principal) {
        return true;
    }

    public Set<String> userRoles(String principal) {
        HashSet<String> set =  new HashSet<String>();
        set.add("user");
        return set;
    }

    public Set<String> userPermissions(String principal) {
        return new HashSet<String>();
    }

}