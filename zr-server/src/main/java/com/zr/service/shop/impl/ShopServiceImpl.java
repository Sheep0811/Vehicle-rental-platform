package com.zr.service.shop.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.shop.ShopMapper;
import com.zr.service.shop.ShopService;
import com.zr.util.TokenUtil;
import com.zr.vo.shop.Shop;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class ShopServiceImpl implements ShopService
{
    @Resource
    private ShopMapper shopMapper;

    @Autowired
    private TokenUtil tokenUtil;

    @Transactional
    @Override
    public List<Shop> list(Shop shop)
    {
        PageHelper.startPage(shop.getPageNum(),shop.getPageSize());
        return shopMapper.list(shop);
    }

    @Override
    public void add(Shop shop) {

        shop.setCreateId(tokenUtil.getUserId());
        shop.setCreateTime(new Date());
        shopMapper.insertSelective(shop);
    }

    @Override
    public void edit(Shop shop) {

        shopMapper.deleteByPrimaryKey(shop.getId());
        shop.setModifyId(tokenUtil.getUserId());
        shop.setModifyTime(new Date());
        shopMapper.insertSelective(shop);
    }

    @Override
    public void del(long id) {
        shopMapper.deleteByPrimaryKey(id);
    }
}
