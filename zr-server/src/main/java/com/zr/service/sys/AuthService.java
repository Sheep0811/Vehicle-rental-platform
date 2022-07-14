package com.zr.service.sys;

import com.zr.vo.sys.Auth;

import java.util.ArrayList;
import java.util.List;

public interface AuthService {
    static List<Auth> createChild(Auth parentAuth, List<Auth> authList) {
        List<Auth> childrenlist = new ArrayList<Auth>();
        for (Auth at: authList) {
            if(parentAuth.getId().equals(at.getPid())){
                childrenlist.add(at);
            }
        }
        return childrenlist;
    }

    List<Auth> list(Auth auth);

    List<Auth> fatherList();

    void add(Auth auth);

    void edit(Auth auth);

    void del(Long id);
}
