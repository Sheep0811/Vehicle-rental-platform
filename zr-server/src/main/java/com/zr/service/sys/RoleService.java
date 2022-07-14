package com.zr.service.sys;

import com.zr.vo.sys.Role;

import java.util.List;

public interface RoleService {
    List<Role> selectList(Role role);

    void add(Role role);

    void del(long id);

    List<Role> list();

    List<Long> listroleauth(long id);

    void changeNameOrMark(Role role);

    void insertroleauth(Long id, List<Long> roleauthlist);

    void addRoleAuth(List<Long> authnumList);
}
