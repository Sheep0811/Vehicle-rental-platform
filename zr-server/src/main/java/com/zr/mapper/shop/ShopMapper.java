package com.zr.mapper.shop;

import com.zr.vo.shop.Shop;

import java.util.List;

public interface ShopMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);

    List<Shop> list(Shop shop);

    String selectFromShopName(Long fromShopId);

    String selectToShopName(Long toShopId);
}