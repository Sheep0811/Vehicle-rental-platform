package com.zr.service.lease.impl;

import com.github.pagehelper.PageHelper;
import com.zr.mapper.lease.AgreementMapper;
import com.zr.service.lease.AgreementService;
import com.zr.util.Md5Util;
import com.zr.util.TokenUtil;
import com.zr.vo.lease.Agreement;
import com.zr.vo.BaseVo;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;





@Service
public class AgreementServiceImpl implements AgreementService {
    @Resource
    private TokenUtil tokenUtil;
    @Resource
    private AgreementMapper agreementMapper;

    public List<Agreement> list(Agreement agreement) {
        //分页插件使用，放在接口方法前，只生效一次
        PageHelper.startPage(agreement.getPageNum(), agreement.getPageSize());
        return agreementMapper.list(agreement);
    }
    /**
     * 新增用户
     * @param agreement
     */
    @Transactional
    public void add(Agreement agreement) {

        agreement.setCreateId(tokenUtil.getUserId());
        agreement.setCreateTime(new Date());
        agreementMapper.insertSelective(agreement);
    }
    /**
     * 新增用户
     * @param agreement
     */
    public void edit(Agreement agreement){
        agreement.setModifyId(tokenUtil.getUserId());
        agreement.setModifyTime(new Date());
        agreementMapper.updateByPrimaryKeySelective(agreement);
    }
    public void del(Long id){
        agreementMapper.deleteByPrimaryKey(id);
    }
}



