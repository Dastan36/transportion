package com.hrbu.mapper.admin;

import com.hrbu.domain.Admin;

import java.util.List;


public interface AdminMapper {


    List<Admin> findAdminList() throws Exception;

    Admin AdminLogin(Admin admin)throws Exception;
}
