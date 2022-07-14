package com.zr.service.car.impl;

import com.github.pagehelper.PageHelper;
import com.mysql.cj.util.StringUtils;
import com.zr.mapper.car.CarMapper;
import com.zr.util.TokenUtil;
import com.zr.vo.car.Car;
import com.zr.service.car.CarService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public  class CarServiceImpl implements CarService {

    private static final String HEAD_FILE_DIR = "E:\\TMP\\img\\car\\";

    @Resource
    private TokenUtil tokenUtil;


    @Resource
    private CarMapper carMapper;

    /**
     * 查询车辆
     * @param car
     * @return
     */

    public List<Car> list(Car car) {
        //分页插件使用，放在接口方法前，只生效一次
        PageHelper.startPage(car.getPageNum(), car.getPageSize());
        return carMapper.list(car);
    }

    /**
     * 新增车辆
     * @param car
     */
    @Transactional
    public void add(Car car) {
        car.setCreateId(tokenUtil.getUserId());
        car.setCreateTime(new Date());
        carMapper.insertSelective(car);
    }

    /**
     * 编辑车辆
     * @param car
     */
    @Transactional
    public void edit(Car car) {
        car.setModifyId(tokenUtil.getUserId());
        car.setModifyTime(new Date());
        carMapper.updateByPrimaryKeySelective(car);
    }

    /**
     * 根据文件地址生成base64编码
     * @param imgUrl
     * @return
     */

    public String loadImgByImgUrl(String imgUrl) {
        if(StringUtils.isNullOrEmpty(imgUrl)) return "";
        byte[] b = new byte[0];
        File file = new File(imgUrl);
        try(FileInputStream fis = new FileInputStream(file)){
            b =  new byte[(int)file.length()];
            fis.read(b);
        }catch (Exception e){}
        return Base64.getEncoder().encodeToString(b);
    }

    /**
     * 图像上传
     * @return String
     */

    public void uploadImg(MultipartFile file) throws IOException {
        String extensionName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
        String path = HEAD_FILE_DIR + UUID.randomUUID().toString() + extensionName;
        File imgFile = new File(path);
        file.transferTo(imgFile);
        Car car = carMapper.selectByPrimaryKey(tokenUtil.getUserId());
        car.setImgUrl(path);
        carMapper.updateByPrimaryKeySelective(car);
    }

    @Override
    public String loadImg() {
        Car car = carMapper.selectByPrimaryKey(tokenUtil.getUserId());
        return loadImgByImgUrl(car.getImgUrl());
    }


    /**
     * 删除车辆
     * @param id
     */
    @Transactional
    public void del(Long id) {
        //删除该用户拥有的角色
        carMapper.deleteByPrimaryKey(id);
    }
}
