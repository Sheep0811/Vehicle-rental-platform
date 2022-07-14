package com.zr.mapper.sys;

import com.zr.vo.sys.Auth;

import java.util.List;

public interface AuthMapper {
    List<Auth> list(Auth auth);

    int deleteByPrimaryKey(Long id);

    int insert(Auth record);

    int insertSelective(Auth record);

    Auth selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Auth record);

    int updateByPrimaryKey(Auth record);

    List<Auth> fatherList();
}