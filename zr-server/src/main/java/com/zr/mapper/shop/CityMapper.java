package com.zr.mapper.shop;

import com.zr.vo.shop.City;

import java.util.List;

public interface CityMapper {
    int deleteByPrimaryKey(Long id);

    int insert(City record);

    int insertSelective(City record);

    City selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(City record);

    int updateByPrimaryKey(City record);

    List<City> list(City city);
    List<City> Getn(Long id);


    List<City> getc();

    City selectByFromShopId(Long fromShopId);

    City selectByToShopId(Long toShopId);

    String selectFromCityName(Long fromShopId);

    String selectToCityName(Long toShopId);
}