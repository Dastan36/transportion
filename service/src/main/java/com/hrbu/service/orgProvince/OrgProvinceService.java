package com.hrbu.service.orgProvince;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Province;

import java.util.List;

public interface OrgProvinceService {

    List<Organize> selectProvinceByOrgId(String orgId);

    List<Province> selectProIdByorgId(String orgId);

}
