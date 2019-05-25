package com.hrbu.service.admin;

import com.hrbu.domain.Admin;


import java.util.List;

public interface AdminService {

    public List<Admin> findAdminList()throws Exception;

    public Admin AdminLogin(Admin admin)throws Exception;
}
