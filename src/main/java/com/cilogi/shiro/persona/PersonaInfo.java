// Copyright (c) 2012 Tim Niblett. All Rights Reserved.
//
// File:        OAuthInfo.java  (08-Oct-2012)
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

import com.google.common.base.Preconditions;

import java.util.logging.Logger;

// The info we store when we perform a successful OAuth request with a token.
public class PersonaInfo {
    static final Logger LOG = Logger.getLogger(PersonaInfo.class.getName());

    private final String token;
    private final String email;

    private PersonaInfo(String token, String email) {
        this.token = token;
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public String getEmail() {
        return email;
    }


    public static class Builder {
        private String token;
        private String email;

        public Builder() {
        }
        public Builder token(String token) { this.token = token; return this; }
        public Builder email(String email) { this.email = email; return this; }

        public PersonaInfo build() {
            Preconditions.checkNotNull(token, "You cannot have an empty token when there are no errors");
            Preconditions.checkNotNull(email, "You cannot have an empty email address when there are no errors");
            return new PersonaInfo(token, email);
        }
    }
}
