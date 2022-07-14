package com.zr.controller.lease;


import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.lease.OrderService;
import com.zr.util.AjaxResult;
import com.zr.vo.lease.Customer;
import com.zr.vo.lease.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/lease/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping("/list")
    public String list(@RequestBody Order order){

        List<Order> orderList  =orderService.list(order);
        PageInfo<Order> pageInfo = new PageInfo<>(orderList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }
}
