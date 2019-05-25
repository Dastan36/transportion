package com.hrbu.controller;

import com.hrbu.domain.Admin;
import com.hrbu.service.admin.AdminServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

import static com.hrbu.sysfranework.validateCode.ValidateCode.RANDOMCODEKEY;

@Controller
public class LoginController {

    @Autowired
    private AdminServiceImpl adminService;


    @RequestMapping(value = {"/tologin"})  //
    public String toLogin(){

        return "redirect:/login.jsp"; // 再次跳转到登录页面
    }

    @RequestMapping(value = {"/index","/"}) //  /transportion/   再次访问无需再次登录
    public String toIndex(){

        return "index";  //跳转到主页面
    }

    @RequestMapping("/login")
    public String adminLogin(HttpSession session, Admin admin, String validatecode) throws Exception {

        admin =  adminService.AdminLogin(admin);


        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);

        if(randomCode.equalsIgnoreCase(validatecode)){
            if(admin != null){
                session.setAttribute("login",true);
                session.setAttribute("adminName",admin.getAdminName());

                return "redirect:/index";  //验证成功跳转到toIndex
            }else{
                session.setAttribute("msg","用户名或密码错误");
                return "redirect:/tologin";  //验证失败跳转到tologin
            }
        }else {
            session.setAttribute("msg","验证码错误");
            return "redirect:/tologin";  //验证失败跳转到tologin
        }
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
