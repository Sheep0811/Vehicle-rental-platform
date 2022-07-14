package com.zr.service.car.impl;


import com.github.pagehelper.PageHelper;
import com.zr.mapper.car.WorkMapper;
import com.zr.service.car.WorkService;
import com.zr.util.TokenUtil;
import com.zr.vo.car.Car;
import com.zr.vo.car.Work;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class WorkServiceimpl implements WorkService {

    @Resource
    private WorkMapper workMapper;

    @Resource
    private TokenUtil tokenUtil;

    public List<Work> list(Work work) {
        //分页插件使用，放在接口方法前，只生效一次
        PageHelper.startPage(work.getPageNum(), work.getPageSize());
        return workMapper.list(work);
    }

    /**
     * 编辑订单
     * @param work
     */

    @Transactional
    public void edit(Work work) {
        work.setModifyId(tokenUtil.getUserId());
        work.setModifyTime(new Date());
        workMapper.updateByPrimaryKeySelective(work);
    }
}
