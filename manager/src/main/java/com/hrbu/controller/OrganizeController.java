package com.hrbu.controller;

import com.hrbu.domain.Organize;
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

    @RequestMapping("/orglist")
    public String findOrgList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        List orgList = organizeService.findOrgList(pageNum);
        int pageCount = organizeService.selectCount();//总条数
        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        model.addAttribute("orgList",orgList);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageCount",pageCount);
        return "organize/org_list";
    }

    @RequestMapping("/toadd")
    public String toAdd(){

        return "organize/org_add";
    }

    @RequestMapping("saveorg")
    public String saveOrg(Organize organize) throws Exception {
        organize.setOrgId(UUID.randomUUID().toString());
        organize.setCreateTime(new Date());
        organizeService.saveOrg(organize);
        return "redirect:/organize/orglist";
    }


    @RequestMapping("/toupdate")
    public String toUpdate(Model model, @RequestParam("orgId")String orgId) throws Exception {
        Organize organize = organizeService.toUpdate(orgId);
        model.addAttribute("organize",organize);
        return "organize/org_update";
    }

    @RequestMapping("/update")
    public String update(Organize organize) throws Exception {
        organizeService.updateOrg(organize);
        return "redirect:/organize/orglist";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(@RequestParam("orgId") String orgId) throws Exception {
        Map map = new HashMap();
        organizeService.deleteOrg(orgId);
        map.put("success",true);
        return map;
    }
}
