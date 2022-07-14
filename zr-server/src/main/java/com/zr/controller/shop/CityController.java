package com.zr.controller.shop;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.shop.CityService;
import com.zr.util.AjaxResult;
import com.zr.util.AjaxResult;
import com.zr.util.RedisUtils;
import com.zr.vo.shop.City;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/shop/city")
public class CityController {

    @Autowired
    private CityService cityService;

    @Autowired
    private RedisUtils redisUtils;

    @RequestMapping("/add")
    public String add(@RequestBody City city)
    {
        cityService.add(city);
        return JSON.toJSONString(AjaxResult.success("新增成功"));
    }

    @RequestMapping("/list")
    public String list(@RequestBody City city)
    {
        List<City> cityList =cityService.list(city);
        PageInfo<City> pageInfo = new PageInfo<>(cityList);
        return JSON.toJSONString(AjaxResult.success("查询成功",pageInfo));
    }

    @RequestMapping("/edit")
    public String edit(@RequestBody City city)
    {
        cityService.edit(city);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }

    @RequestMapping("/del/{id}")
    public String del(@PathVariable("id") long id)
    {
        cityService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }

    @RequestMapping("/getc")
    public String getc()
    {
        List<City> cList = cityService.getc();
        return JSON.toJSONString(AjaxResult.success("查询成功",cList));
    }
}
