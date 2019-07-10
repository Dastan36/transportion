package com.hrbu.service.organized;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Province;
import com.hrbu.mapper.orgProvince.OrgProvinceMapper;
import com.hrbu.mapper.organize.OrganizeMapper;
import com.hrbu.mapper.provine.ProvinceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class OrganizeServiceImpl implements OrganizeService {


    @Autowired
    private OrganizeMapper organizeMapper;

    @Autowired
    private OrgProvinceMapper orgProvinceMapper;

    @Autowired
    private ProvinceMapper provinceMapper;

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
    public boolean saveOrg(Organize organize,String[] proId) throws Exception{
        organize.setOrgId(UUID.randomUUID().toString());
        organize.setCreateTime(new Date());
        int count = organizeMapper.saveOrg(organize);
        //在这里将机构的管辖区域 添加进来
        if(count>0){
            Map map = new HashMap();
            map.put("proId",proId);
            map.put("orgId",organize.getOrgId());
            int count2 = orgProvinceMapper.insertProvinceOrganize(map);
            return count2>0;
        }
        return false;
    }

    @Override
    public boolean deleteOrg(String orgId) throws Exception{
//删除机构 要先删除关联表 t_org_pro  t_train
        int preDel = orgProvinceMapper.deleteProOrg(orgId);
        if (preDel>0){
            int count = organizeMapper.deleteOrg(orgId);
            return count>0;
        }
        return false;
    }

    @Override
    public Organize toUpdate(String orgId) throws Exception{

        Organize organize = organizeMapper.findOrgById(orgId);
        return organize;
    }
//找到proId 界面上显示 管辖
    @Override
    public List<Province> toUpdateSelectproId(String orgId) throws Exception {
        List<Province> proList = orgProvinceMapper.selectProIdByorgId(orgId);
        return proList;
    }

    @Override
    public boolean updateOrg(Organize organize,String[] proId) throws Exception{

        int count = organizeMapper.updateOrg(organize);
        //修改 机构的管辖区域  由于是一对多 实现修改要先删(关系表)后添
        if (count>0){

            int delCount = orgProvinceMapper.deleteProOrg(organize.getOrgId());//shan
            //tian
                Map map = new HashMap();
                map.put("proId",proId);
                map.put("orgId",organize.getOrgId());
                int addCount = orgProvinceMapper.insertProvinceOrganize(map);
                return addCount>0;
        }

        return false;
    }

    @Override
    public String selectIdByAdminName(String orgName) throws Exception {
        return organizeMapper.selectIdByAdminName(orgName);
    }
}
