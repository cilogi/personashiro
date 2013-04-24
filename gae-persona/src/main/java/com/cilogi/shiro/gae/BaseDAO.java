package com.cilogi.shiro.gae;

import com.google.common.base.Preconditions;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class  BaseDAO<T> {
    static final Logger LOG = LoggerFactory.getLogger(BaseDAO.class);

    private final Class clazz;

    public BaseDAO(Class clazz) {
        this.clazz = clazz;
    }

    public static Objectify ofy() {
        return ObjectifyService.ofy();
    }

    @SuppressWarnings({"unchecked"})
    public T get(String id) {
        if (id == null || "".equals(id)) {
            return null;
        }
        return (T)ofy().load().key(Key.create(clazz, id)).get();
    }

    public void put(T object) {
        Preconditions.checkNotNull(object, "Can't save null object");
        ofy().save().entity(object).now();
    }

    @SuppressWarnings({"unchecked"})
    public void delete(String id) {
        Preconditions.checkNotNull(id, "Can't delete null object");
        ofy().delete().key(Key.create(clazz, id));
    }

}