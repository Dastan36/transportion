package com.hrbu.mapper.admin;

import com.hrbu.domain.Admin;

import java.util.List;
import java.util.Map;


public interface AdminMapper {

    int selectCount() throws Exception;

    List<Admin> findAdminList(Map map) throws Exception;

    Admin AdminLogin(Admin admin)throws Exception;

    Admin findAdminById(String adminId) throws Exception;

    int saveAdmin(Admin admin) throws Exception;

    int deleteAdmin(String adminId) throws Exception;

    int updateAdmin(Admin admin) throws Exception;
}
