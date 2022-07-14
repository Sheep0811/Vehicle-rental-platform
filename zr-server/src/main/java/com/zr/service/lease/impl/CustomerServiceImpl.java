package com.zr.service.lease.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.lease.CustomerMapper;
import com.zr.service.lease.CustomerService;
import com.zr.util.Md5Util;
import com.zr.util.TokenUtil;
import com.zr.vo.lease.Customer;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;



@Service
public class CustomerServiceImpl implements CustomerService {
    @Resource
    private TokenUtil tokenUtil;
    @Resource
    private CustomerMapper customerMapper;

    public List<Customer> list(Customer customer) {
        //分页插件使用，放在接口方法前，只生效一次
        PageHelper.startPage(customer.getPageNum(), customer.getPageSize());
        return customerMapper.list(customer);
    }
    /**
     * 新增用户
     * @param customer
     */
    @Transactional
    public void add(Customer customer) {

        customer.setCreateId(tokenUtil.getUserId());
        customer.setCreateTime(new Date());
        customerMapper.insertSelective(customer);
    }
    /**
     * 新增用户
     * @param customer
     */
    public void edit(Customer customer){
        customer.setModifyId(tokenUtil.getUserId());
        customer.setModifyTime(new Date());
        customerMapper.updateByPrimaryKeySelective(customer);
    }

    public void del(Long id){
        customerMapper.deleteByPrimaryKey(id);
    }
}


