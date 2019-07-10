package com.hrbu.service.organized;

import com.hrbu.domain.Organize;

import java.util.List;

public interface OrganizeService {

    int selectCount() throws Exception;

    List<Organize> findOrgList(int pageNum) throws Exception;

    Organize findOrgById(String orgId) throws Exception;

    boolean saveOrg(Organize organize,String[] proId) throws Exception;

    boolean deleteOrg(String orgId) throws Exception;

    Organize toUpdate(String orgId) throws Exception;
    List toUpdateSelectproId(String orgId) throws Exception;

    boolean updateOrg(Organize organize,String[] proId) throws Exception;

    String selectIdByAdminName(String orgName) throws Exception;


}
