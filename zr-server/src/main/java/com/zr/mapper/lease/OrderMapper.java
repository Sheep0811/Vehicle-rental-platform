package com.zr.mapper.lease;

import com.zr.vo.lease.Order;

import java.util.List;

public interface OrderMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    List<Order> list(Order order);

    String selectCustomerName(String customerId);

    String selectCarName(String carId);

    String selectFromShop(String fromShopId);

    String selectFromCity(String fromShopId);

    String selectToShop(String toShopId);

    String selectToCity(String toShopId);

    String selectAgreementId(String AgreementId);

    List<Order> searchtimewithcar(Order order);

    List<Order> searchtimewithDate(Order order);

    List<Order> searchpaywithcar(Order order);

    List<Order> searchpaywithDate(Order order);
}