package com.hrbu.service.admin;

import com.hrbu.domain.Admin;

import java.util.List;
import java.util.Map;

public interface AdminService {

    int selectCount() throws Exception;

    List<Admin> findAdminList(Map map)throws Exception;

    Admin AdminLogin(Admin admin)throws Exception;

    Admin findAdminById(String adminId) throws Exception;

    boolean saveAdmin(Admin admin) throws Exception;

    boolean deleteAdmin(String adminId) throws Exception;

    boolean updateAdmin(Admin admin) throws Exception;
}
