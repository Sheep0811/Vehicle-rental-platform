package com.zr.service.car;

import com.zr.vo.car.Car;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;


public interface CarService {

    List<Car> list(Car car);

    void add(Car car);

    void del(Long id);

    void edit(Car car);

    void uploadImg(MultipartFile file) throws IOException;

    String loadImg();

}
