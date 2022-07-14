package com.zr.controller.lease;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.lease.CustomerService;
import com.zr.util.AjaxResult;
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
@RequestMapping("/lease/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/list")
    public String list(@RequestBody Customer customer){
        //查询用户列表
        System.out.println("aaaaaaaaa");
        List<Customer> customerList = customerService.list(customer);
        //封装到分页对象中
        PageInfo<Customer> pageInfo = new PageInfo<>(customerList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }


    @RequestMapping("/add")
    public String add(@RequestBody Customer customer){
        customerService.add(customer);
        return JSON.toJSONString(AjaxResult.success("添加成功"));
    }

    @RequestMapping("/edit")
    public String edit(@RequestBody Customer customer){
        customerService.edit(customer);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }
    @RequestMapping("/del/{id}")
    public  String del(@PathVariable("id") Long id){
        customerService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }
}
