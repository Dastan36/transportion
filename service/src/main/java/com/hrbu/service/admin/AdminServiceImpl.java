package com.hrbu.service.admin;

import com.hrbu.domain.Admin;
import com.hrbu.mapper.admin.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public int selectCount() throws Exception {
        return adminMapper.selectCount();
    }

    @Override
    public List<Admin> findAdminList(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        List list = adminMapper.findAdminList(map);
        return list;
    }

    @Override
    public Admin AdminLogin(Admin admin) throws Exception{

        return adminMapper.AdminLogin(admin);
    }

    @Override
    public Admin findAdminById(String adminId) throws Exception {
        return adminMapper.findAdminById(adminId);
    }

    @Override
    public boolean saveAdmin(Admin admin) throws Exception {
        int count = adminMapper.saveAdmin(admin);
        return count>0;
    }

    @Override
    public boolean deleteAdmin(String adminId) throws Exception {
        int count = adminMapper.deleteAdmin(adminId);
        return count>0;
    }

    @Override
    public boolean updateAdmin(Admin admin) throws Exception {
        int count = adminMapper.updateAdmin(admin);
        return count>0;
    }

}
