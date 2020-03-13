package com.hrbu.controller;

import com.hrbu.domain.Admin;
import com.hrbu.service.admin.AdminServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminServiceImpl adminService;

    @RequestMapping("/tolist")
    public String toList(){

        return "admin/admin_list";
    }


    @ResponseBody
    @RequestMapping("/adminlist")
    public Map AdminList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        Map map = new HashMap();          //get到查询条件
        map.put("pageNum",pageNum);
        List<Admin> adminList = adminService.findAdminList(map);
        int pageCount = adminService.selectCount();//总条数
        //pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("adminList",adminList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("adminList",adminList);
        map.put("pageCount",pageCount);
        return map;
    }

    @RequestMapping("/toadd")
    public String toAdd(){

        return "admin/admin_add";
    }

    @ResponseBody
    @RequestMapping("saveadmin")
    public boolean saveUser(Admin admin) throws Exception {
        admin.setAdminId(UUID.randomUUID().toString());
        admin.setCreateTime(new Date());
        boolean flag = false;
        flag = adminService.saveAdmin(admin);
        return flag;
    }



    @RequestMapping("/toupdate")
    public String toUpdate(Model model, String adminId) throws Exception {
        Admin admin = adminService.findAdminById(adminId);
        model.addAttribute("admin",admin);
        return "admin/admin_update";
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(Admin admin) throws Exception {
        boolean flag = false;
        flag = adminService.updateAdmin(admin);
        return flag;
    }

    @RequestMapping("/delete")
    @ResponseBody                                //ajax 传参删除
    public Map delete(String adminId) throws Exception {
        Map map = new HashMap();
        adminService.deleteAdmin(adminId);
        map.put("success",true);
        return map;
    }






}
