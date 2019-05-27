package com.hrbu.mapper.orgProvince;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrgProvinceMapper {

    List<Organize> selectProvinceByOrgId(String orgId);
}
