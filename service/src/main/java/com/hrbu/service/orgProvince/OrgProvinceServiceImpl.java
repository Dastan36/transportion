package com.hrbu.service.orgProvince;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Province;
import com.hrbu.mapper.orgProvince.OrgProvinceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgProvinceServiceImpl implements OrgProvinceService {

    @Autowired
    private OrgProvinceMapper orgProvinceMapper;


    @Override
    public List<Organize> selectProvinceByOrgId(String orgId) {
        return orgProvinceMapper.selectProvinceByOrgId(orgId);
    }

    @Override
    public List<Province> selectProIdByorgId(String orgId) {
        return orgProvinceMapper.selectProIdByorgId(orgId);
    }

}
