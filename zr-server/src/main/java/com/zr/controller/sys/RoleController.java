package com.zr.controller.sys;
import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.zr.service.sys.RoleService;
import com.zr.util.AjaxResult;
import com.zr.vo.sys.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/sys/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    /**
     * 获取所有角色列表
     * @return
     */
    @RequestMapping("/selectList")
    public String selectList(@RequestBody Role role){
        List<Role> roleList = roleService.selectList(role);
        PageInfo<Role> pageInfo = new PageInfo<>(roleList);
        return JSON.toJSONString(AjaxResult.success("查询成功", pageInfo));
    }
    @RequestMapping("/list")
    public String list(){
        List<Role> roleList = roleService.list();
        return JSON.toJSONString(AjaxResult.success("查询成功", roleList));
    }
    @RequestMapping("/add")
    public String add(@RequestBody Role role){
        roleService.add(role);
        roleService.addRoleAuth(role.getAuthnumList());
        return JSON.toJSONString(AjaxResult.success("新增成功"));
    }
    @RequestMapping("/del/{id}")
    public  String del(@PathVariable("id") long id){
        roleService.del(id);
        return JSON.toJSONString(AjaxResult.success("删除成功"));
    }
    @RequestMapping("/listroleauth/{id}")
    public String listroleauth(@PathVariable("id") long id){
        List<Long> roleauth = roleService.listroleauth(id);
        return JSON.toJSONString(AjaxResult.success("查询成功",roleauth));
    }
    @RequestMapping("/edit")
    public String insertroleauth(@RequestBody Role role) {
        roleService.changeNameOrMark(role);
        List<Long> roleauthlist=role.getAuthnumList();
        roleService.insertroleauth(role.getId(),roleauthlist);
        return JSON.toJSONString(AjaxResult.success("插入成功"));
    }

}

