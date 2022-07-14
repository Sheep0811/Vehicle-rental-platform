package com.zr.controller.lease;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.lease.AgreementService;
import com.zr.service.lease.CustomerService;
import com.zr.util.AjaxResult;
import com.zr.vo.lease.Agreement;
import com.zr.vo.lease.Customer;
import com.zr.vo.sys.Auth;
import com.zr.vo.sys.User;
import net.sf.jsqlparser.expression.JsonAggregateFunction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.ArrayList;
import java.util.List;



@RestController
@RequestMapping("/lease/agreement")
public class AgreementController {

    @Autowired
    private AgreementService agreementService;

    @RequestMapping("/list")
    public String list(@RequestBody Agreement agreement){
        //查询用户列表
        System.out.println("aaaaaaaaa");
        List<Agreement> agreementList = agreementService.list(agreement);
        //封装到分页对象中
        PageInfo<Agreement> pageInfo = new PageInfo<>(agreementList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }


    @RequestMapping("/add")
    public String add(@RequestBody Agreement agreement){
        agreementService.add(agreement);
        return JSON.toJSONString(AjaxResult.success("添加成功"));
    }

    @RequestMapping("/edit")
    public String edit(@RequestBody Agreement agreement){
        agreementService.edit(agreement);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }
    @RequestMapping("/del/{id}")
    public  String del(@PathVariable("id") Long id){
        agreementService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }
}
