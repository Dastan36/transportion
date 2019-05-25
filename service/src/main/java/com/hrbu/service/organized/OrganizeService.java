package com.hrbu.service.organized;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrganizeService {

    int selectCount() throws Exception;

    List<Organize> findOrgList(int pageNum) throws Exception;

    Organize findOrgById(String orgId) throws Exception;

    void saveOrg(Organize organize) throws Exception;

    void deleteOrg(String orgId) throws Exception;

    Organize toUpdate(String orgId) throws Exception;

    void updateOrg(Organize organize) throws Exception;


}
