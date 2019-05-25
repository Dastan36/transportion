package com.hrbu.service.admin;

import com.hrbu.domain.Admin;
import com.hrbu.mapper.admin.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public List<Admin> findAdminList() throws Exception{

        List list = adminMapper.findAdminList();
        return list;
    }

    @Override
    public Admin AdminLogin(Admin admin) throws Exception{

        return adminMapper.AdminLogin(admin);
    }

}
