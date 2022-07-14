package com.zr.service.lease;

import com.zr.vo.lease.Customer;


import java.util.List;

public interface CustomerService {
    List<Customer> list(Customer customer);

    void add(Customer customer);

    void edit(Customer customer);

    void del(Long id);

}
