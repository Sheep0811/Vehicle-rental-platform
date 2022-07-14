package com.zr.mapper.car;

import com.zr.vo.car.Car;
import com.zr.vo.car.Work;

import java.util.List;

public interface WorkMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Work record);

    int insertSelective(Work record);

    Work selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Work record);

    int updateByPrimaryKey(Work record);

    List<Work> list(Work work);
}