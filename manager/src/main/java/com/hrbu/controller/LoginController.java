package com.hrbu.controller;

import com.hrbu.domain.Admin;
import com.hrbu.domain.Province;
import com.hrbu.service.admin.AdminServiceImpl;
import com.hrbu.service.orgProvince.OrgProvinceService;
import com.hrbu.service.organized.OrganizeService;
import com.hrbu.service.province.ProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.hrbu.sysfranework.validateCode.ValidateCode.RANDOMCODEKEY;

@Controller
public class LoginController {

    @Autowired
    private AdminServiceImpl adminService;
    @Autowired
    private OrganizeService organizeService;
    @Autowired
    private OrgProvinceService orgProvinceService;
    @Autowired
    private ProvinceService provinceService;
    @RequestMapping(value = {"/tologin"})  //
    public String toLogin(){

        return "redirect:/login.jsp"; // 再次跳转到登录页面
    }

    @RequestMapping(value = {"/index","/"}) //  /transportion/   再次访问无需再次登录
    public String toIndex(){

        return "index";  //跳转到主页面
    }

    @RequestMapping("/login")
    public String adminLogin(HttpSession session, Admin admin, @RequestParam(required=false) String validatecode) throws Exception {

        admin =  adminService.AdminLogin(admin);


        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);

        if(admin != null){
            session.setAttribute("login",true);
            String adminName = admin.getAdminName();
            session.setAttribute("adminName",adminName);//adminName 和机构名一样
            String orgId = organizeService.selectIdByAdminName(adminName);//找到orgId
            //通过orgId 机构 找到每个铁路局管辖的省市自治区
            if (orgId != null) {//国家的没有orgId
                //通过orgID 找到 proId 进而得到 province
                List<Province> provinceList = orgProvinceService.selectProIdByorgId(orgId);
                //provinceList.get(0).getProId();
                List proId = new ArrayList();
                for(int i = 0;i<provinceList.size();i++){
                    proId.add(provinceList.get(i).getProId());
                }
                //分局的管辖区域
                List<Province> provinces = provinceService.selectProNameById(proId);

                session.setAttribute("provinces", provinces);
            }
            return "redirect:/index";  //验证成功跳转到toIndex
        }else{
            session.setAttribute("msg","用户名或密码错误");
            return "redirect:/tologin";  //验证失败跳转到tologin
        }

        /*if(randomCode.equalsIgnoreCase(validatecode)){
            if(admin != null){
                session.setAttribute("login",true);
                String adminName = admin.getAdminName();
                session.setAttribute("adminName",adminName);//adminName 和机构名一样
                String orgId = organizeService.selectIdByAdminName(adminName);//找到orgId
                //通过orgId 机构 找到每个铁路局管辖的省市自治区
                if (orgId != null) {//国家的没有orgId
                    List<Organize> organizes = orgProvinceService.selectProvinceByOrgId(orgId);
                    List<Province> provinces = organizes.get(0).getProvince();
                    session.setAttribute("provinces", provinces);
                }
                return "redirect:/index";  //验证成功跳转到toIndex
            }else{
                session.setAttribute("msg","用户名或密码错误");
                return "redirect:/tologin";  //验证失败跳转到tologin
            }
        }else {
            session.setAttribute("msg","验证码错误");
            return "redirect:/tologin";  //验证失败跳转到tologin
        }*/
    }

    /**
     * 验证验证码
     * @param session
     * @param validate
     * @return
     */
    @ResponseBody
    @RequestMapping("/val")
    public Map validate(HttpSession session, String validate){
        Map map = new HashMap();
        System.out.println(validate);
        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);
        if (randomCode.equalsIgnoreCase(validate)) {
            map.put("validate","true");
        }else{
            map.put("validate","false");
        }
        return map;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();//清楚session
        return "redirect:/tologin";
    }

}
