package com.hrbu.mapper.orgProvince;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Province;

import java.util.List;
import java.util.Map;

public interface OrgProvinceMapper {

    List<Organize> selectProvinceByOrgId(String orgId);

    int insertProvinceOrganize(Map map);

    int deleteProOrg(String orgId);

    List<Province> selectProIdByorgId(String orgId);



}
