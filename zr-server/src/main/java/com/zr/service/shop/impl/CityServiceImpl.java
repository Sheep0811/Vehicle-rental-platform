package com.zr.service.shop.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.shop.CityMapper;
import com.zr.mapper.shop.ProvinceMapper;
import com.zr.service.shop.CityService;
import com.zr.util.TokenUtil;
import com.zr.vo.shop.City;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class CityServiceImpl implements CityService
{
    @Resource
    private CityMapper cityMapper;

    @Resource
    private ProvinceMapper provinceMapper;

    @Autowired
    private TokenUtil tokenUtil;


    @Transactional
    @Override
    public List<City> list(City city)
    {
        PageHelper.startPage(city.getPageNum(),city.getPageSize());
        return cityMapper.list(city);
    }

    @Transactional
    @Override
    public void add(City city) {

        city.setCreateTime(new Date());
        city.setCreateId(tokenUtil.getUserId());
        cityMapper.insertSelective(city);


    }

    @Transactional
    @Override
    public void edit(City city) {

        cityMapper.deleteByPrimaryKey(city.getId());
        city.setModifyTime(new Date());
        city.setModifyId(tokenUtil.getUserId());
        cityMapper.insertSelective(city);
    }

    @Transactional
    @Override
    public void del(long id) {

        cityMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<City> getc() {
       return cityMapper.getc();
    }
}
