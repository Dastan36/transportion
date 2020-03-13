package com.hrbu.mapper.provine;

import com.hrbu.domain.Province;

import java.util.List;

public interface ProvinceMapper {

    List<Province> selectProNameById(List proId);
}
