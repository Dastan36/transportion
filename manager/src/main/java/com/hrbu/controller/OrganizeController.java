package com.hrbu.controller;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Province;
import com.hrbu.service.organized.OrganizeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/organize")
public class OrganizeController {


    @Autowired
    private OrganizeService organizeService;


    @RequestMapping("/tolist")
    public String toList(){

        return "organize/org_list";
    }

    @ResponseBody
    @RequestMapping("/orglist")
    public Map findOrgList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        List orgList = organizeService.findOrgList(pageNum);
        int pageCount = organizeService.selectCount();//总条数
//        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("orgList",orgList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        Map map  = new HashMap();
        map.put("orgList",orgList);
        map.put("pageCount",pageCount);
        return map;
    }

    @RequestMapping("/toadd")
    public String toAdd(){

        return "organize/org_add";
    }

    @ResponseBody
    @RequestMapping("saveorg")
    public boolean saveOrg(Organize organize,String[] proId) throws Exception {

        boolean flag = false;
        //添加机构时 在service中又将机构管辖加入
        flag = organizeService.saveOrg(organize,proId);

        return flag;
    }


    @RequestMapping("/toupdate")
    public String toUpdate(Model model, @RequestParam("orgId")String orgId) throws Exception {

        Organize organize = organizeService.toUpdate(orgId);
        List<Province> proList = organizeService.toUpdateSelectproId(orgId);
        model.addAttribute("organize",organize);
        model.addAttribute("proList",proList);
        return "organize/org_update";
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(Organize organize, String[] proId) throws Exception {
        boolean flag = false;
        flag = organizeService.updateOrg(organize,proId);
        return flag;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(@RequestParam("orgId") String orgId) throws Exception {
        Map map = new HashMap();
        boolean flag = false;
        flag = organizeService.deleteOrg(orgId);  //删除机构 要先删除关联表
        if (flag){
            map.put("success",true);
        }else{
            map.put("success",false);
        }
        return map;
    }
}
