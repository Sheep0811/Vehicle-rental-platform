package com.zr.mapper.sys;

import com.zr.vo.sys.Auth;
import com.zr.vo.sys.Role;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

    List<Role> listByUserId(String userId);

    List<Role> selectList(Role role);

    List<Role> list();

    List<Auth> selectRoleAuth();

    List<Long> listroleauth(long id);

    void deletroleauth(Long id);

    void insertroleauth(Long id, Long authnum);

    long getmaxid();
}