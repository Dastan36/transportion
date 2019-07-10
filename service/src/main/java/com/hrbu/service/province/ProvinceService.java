package com.hrbu.service.province;

import com.hrbu.domain.Province;
import org.springframework.stereotype.Service;

import java.util.List;


public interface ProvinceService {

    List<Province> selectProNameById(List proId);
}
