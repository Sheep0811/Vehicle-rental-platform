package com.zr.controller.car;


import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.car.CarService;
import com.zr.service.car.WorkService;
import com.zr.util.AjaxResult;
import com.zr.vo.car.Car;
import com.zr.vo.car.Work;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/car/work")
public class WorkController {

    @Autowired
    private WorkService workService;

    @RequestMapping("/list")
    public String list(@RequestBody Work work){
        //查询车辆列表
        List<Work> workList = workService.list(work);
        //封装到分页对象中
        PageInfo<Work> pageInfo = new PageInfo<>(workList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }

    /**
     * 编辑订单
     * @param work
     * @return
     */
    @RequestMapping("/edit")
    public String edit(@RequestBody  Work work){
        workService.edit(work);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }


}
