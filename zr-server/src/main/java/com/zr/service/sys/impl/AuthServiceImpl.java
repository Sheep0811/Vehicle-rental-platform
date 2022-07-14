package com.zr.service.sys.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.sys.AuthMapper;
import com.zr.service.sys.AuthService;
import com.zr.util.TokenUtil;
import com.zr.vo.sys.Auth;
import com.zr.vo.sys.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class AuthServiceImpl implements AuthService {
    @Resource
    private AuthMapper authMapper;

    @Autowired
    private TokenUtil tokenUtil;

    @Override
    public List<Auth> list(Auth auth){
        PageHelper.startPage(auth.getPageNum(),auth.getPageSize());
        return authMapper.list(auth);
    }

    @Override
    public List<Auth> fatherList(){
        return authMapper.fatherList();
    }

    @Override
    public void add(Auth auth){
        auth.setCreateId(tokenUtil.getUserId());
        auth.setCreateTime(new Date());
        authMapper.insertSelective(auth);
    }

    @Override
    public void edit(Auth auth){
        auth.setModifyId(tokenUtil.getUserId());
        auth.setModifyTime(new Date());
        authMapper.updateByPrimaryKeySelective(auth);
    }

    @Override
    public void del(Long id){
        authMapper.deleteByPrimaryKey(id);
    }
}
