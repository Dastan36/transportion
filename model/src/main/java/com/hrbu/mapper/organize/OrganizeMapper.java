package com.hrbu.mapper.organize;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrganizeMapper {

    int selectCount() throws Exception;

    List<Organize> findOrgList(int pageRow) throws Exception;

    Organize findOrgById(String orgId) throws Exception;

    int saveOrg(Organize organize) throws Exception;

    int deleteOrg(String orgId) throws Exception;

    int updateOrg(Organize organize) throws Exception;

    String selectIdByAdminName(String orgName) throws Exception;

}
