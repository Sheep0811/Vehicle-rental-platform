package com.zr.controller.shop;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.shop.ShopService;
import com.zr.util.AjaxResult;
import com.zr.util.AjaxResult;
import com.zr.util.RedisUtils;
import com.zr.vo.shop.Shop;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/shop/shop")
public class ShopController {

    @Autowired
    private ShopService shopService;

    @Autowired
    private RedisUtils redisUtils;

    @RequestMapping("/list")
    public String list(@RequestBody Shop shop)
    {
        List<Shop> shopList =shopService.list(shop);
        PageInfo<Shop> pageInfo = new PageInfo<>(shopList);
        return JSON.toJSONString(AjaxResult.success("查询成功",pageInfo));
    }

    @RequestMapping("/add")
    public String add(@RequestBody Shop shop)
    {
        shopService.add(shop);
        return JSON.toJSONString(AjaxResult.success("新增成功"));
    }

    @RequestMapping("/edit")
    public String edit(@RequestBody Shop shop)
    {
        shopService.edit(shop);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }

    @RequestMapping("/del/{id}")
    public String del(@PathVariable("id") long id)
    {
        shopService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }
}
