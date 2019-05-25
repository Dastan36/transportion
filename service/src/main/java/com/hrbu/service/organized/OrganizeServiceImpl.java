package com.hrbu.service.organized;

import com.hrbu.domain.Organize;
import com.hrbu.mapper.organize.OrganizeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class OrganizeServiceImpl implements OrganizeService {


    @Autowired
    private OrganizeMapper organizeMapper;

    @Override
    public int selectCount() throws Exception{

        return organizeMapper.selectCount();
    }

    @Override
    public List<Organize> findOrgList(int pageNum) throws Exception{
        int pageRow = (pageNum-1) * 9;
        List<Organize> list = organizeMapper.findOrgList(pageRow);
        return list;
    }

    @Override
    public Organize findOrgById(String orgId) throws Exception{
        Organize organize = organizeMapper.findOrgById(orgId);
        return organize;
    }

    @Override
    public void saveOrg(Organize organize) throws Exception{

        organizeMapper.saveOrg(organize);
    }

    @Override
    public void deleteOrg(String orgId) throws Exception{

        organizeMapper.deleteOrg(orgId);
    }

    @Override
    public Organize toUpdate(String orgId) throws Exception{

        Organize organize = organizeMapper.findOrgById(orgId);
        return organize;
    }

    @Override
    public void updateOrg(Organize organize) throws Exception{

        organizeMapper.updateOrg(organize);
    }
}
