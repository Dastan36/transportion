package com.hrbu.service.province;

import com.hrbu.domain.Province;
import com.hrbu.mapper.provine.ProvinceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ProvinceSericeImpl implements ProvinceService{

    @Autowired
    private ProvinceMapper provinceMapper;

    @Override
    public List<Province> selectProNameById(List proId) {
        return provinceMapper.selectProNameById(proId);
    }
}
