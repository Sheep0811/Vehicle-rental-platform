package com.zr.service.sys.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.sys.RoleMapper;
import com.zr.service.sys.RoleService;
import com.zr.util.TokenUtil;
import com.zr.vo.sys.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private TokenUtil tokenUtil;
    @Resource
    private RoleMapper roleMapper;


    @Override
    public List<Role> selectList(Role role) {
        PageHelper.startPage(role.getPageNum(), role.getPageSize());
        return roleMapper.selectList(role);
    }

    @Override
    public void add(Role role) {
        role.setCreateTime(new Date());
        role.setModifyTime(new Date());
        role.setCreateId(tokenUtil.getUserId());
        roleMapper.insertSelective(role);
    }

    @Override
    public void del(long id) {
        roleMapper.deleteByPrimaryKey((long) id);
    }

    @Override
    public List<Role> list() {
        return roleMapper.list();
    }

    @Override
    public List<Long> listroleauth(long id) {
        return roleMapper.listroleauth(id);
    }


    @Override
    public void changeNameOrMark(Role role) {
        role.setModifyTime(new Date());
        roleMapper.updateByPrimaryKey(role);
    }

    @Override
    public void insertroleauth(Long id, List<Long> roleauthlist) {
        roleMapper.deletroleauth(id);
            for(int i=0;i<roleauthlist.size();i++){
                roleMapper.insertroleauth(id, roleauthlist.get(i));
            }
    }

    @Override
    public void addRoleAuth(List<Long> authnumList) {
        long maxid = roleMapper.getmaxid();
        insertroleauth(maxid,authnumList);
    }
}

