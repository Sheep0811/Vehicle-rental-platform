package com.zr.controller.sys;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.sys.AuthService;
import com.zr.util.AjaxResult;
import com.zr.vo.sys.Auth;

import net.sf.jsqlparser.expression.JsonAggregateFunction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;



@RestController
@RequestMapping("/sys/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @RequestMapping("/list")
    public String list(@RequestBody Auth auth){
        List<Auth> authList = authService.list(auth);
        List<Auth> resultList = new ArrayList<Auth>();

        for (Auth at: authList) {
            String pid = String.valueOf(at.getPid());
            if(pid == "" || "null".equals(pid)){
                List<Auth> childrenlist = AuthService.createChild(at,authList);
                if(childrenlist.size()>0){
                    at.setChildren(childrenlist);
                }
                resultList.add(at);
            }
        }
        PageInfo<Auth> pageInfo = new PageInfo<>(resultList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }

    @RequestMapping("/father")
    public String fatherList(){
        List<Auth> father = authService.fatherList();
        return JSON.toJSONString(AjaxResult.success("查询成功",father));
    }

    @RequestMapping("/add")
    public String add(@RequestBody Auth auth){
        authService.add(auth);
        return JSON.toJSONString(AjaxResult.success("添加成功"));
    }

    @RequestMapping("/edit")
    public String edit(@RequestBody Auth auth){
        authService.edit(auth);
        return JSON.toJSONString(AjaxResult.success("编辑成功"));
    }
    @RequestMapping("/del/{id}")
    public  String del(@PathVariable("id") Long id){
        authService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }
}
