package com.hrbu.mapper.organize;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrganizeMapper {

    int selectCount() throws Exception;

    List<Organize> findOrgList(int pageRow) throws Exception;

    Organize findOrgById(String orgId) throws Exception;

    void saveOrg(Organize organize) throws Exception;

    void deleteOrg(String orgId) throws Exception;

    void updateOrg(Organize organize) throws Exception;


}
