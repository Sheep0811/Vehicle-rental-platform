package com.zr.mapper.car;

import com.zr.vo.car.Car;

import java.util.List;

public interface CarMapper {

    int deleteByPrimaryKey(Long id);

    int insert(Car record);

    int insertSelective(Car record);

    Car selectByPrimaryKey(String name);

    int updateByPrimaryKeySelective(Car record);

    int updateByPrimaryKey(Car record);

    List<Car> list(Car car);
}