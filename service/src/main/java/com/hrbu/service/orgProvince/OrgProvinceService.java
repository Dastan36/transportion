package com.hrbu.service.orgProvince;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrgProvinceService {

    List<Organize> selectProvinceByOrgId(String orgId);

}
