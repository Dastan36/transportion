package com.hrbu.controller;

import com.hrbu.domain.Admin;
import com.hrbu.service.admin.AdminServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminServiceImpl adminService;



    @RequestMapping("/adminlist")
    public String AdminList(Model model) throws Exception {
        List<Admin> adminList = adminService.findAdminList();
        model.addAttribute("adminList",adminList);
        return "admin/admin_list";
    }


}
