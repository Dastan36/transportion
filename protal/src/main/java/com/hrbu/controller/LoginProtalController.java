package com.hrbu.controller;

import com.hrbu.domain.User;
import com.hrbu.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Map;

import static com.hrbu.sysfranework.validate.ValidateCode.RANDOMCODEKEY;

@Controller

public class LoginProtalController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/index","/"})
    public String protal(){

        return "protal";
    }

    @RequestMapping("/order")  //游客身份
    public String toOrder(){

        return "order/order";
    }

    @RequestMapping("touserlogin")
    public String toLogin(){

        return "redirect:/login.jsp"; // 跳转到登录页面
    }

    @RequestMapping("/center")
    public String toCenter(){

        return "center";
    }

    @RequestMapping("/userlogin")
    public String adminLogin(HttpSession session, User user, @RequestParam(required=false) String validatecode) throws Exception {

        user =  userService.userLogin(user);


        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);

        /*if(randomCode.equalsIgnoreCase(validatecode)){
            if(user != null){
                session.setAttribute("login",true);
                session.setAttribute("user",user);
                session.setAttribute("userId",user.getUserId());

                return "redirect:/center";  //验证成功跳转到center
            }else{
                session.setAttribute("msg","手机号或密码错误");
                return "redirect:/touserlogin";  //验证失败跳转到tologin
            }
        }else {
            session.setAttribute("msg","验证码错误");
            return "redirect:/touserlogin";  //验证失败跳转到tologin
        }*/
        if(user != null){
            if(!user.getStatus().equals("1")){
                session.setAttribute("msg","暂无登录资格");
                return "redirect:/touserlogin";  //验证失败跳转到tologin
            }else{
                session.setAttribute("login",true);
                session.setAttribute("user",user);
                session.setAttribute("userId",user.getUserId());

                return "redirect:/center";  //验证成功跳转到center
            }

        }else{
            session.setAttribute("msg","手机号或密码错误");
            return "redirect:/touserlogin";  //验证失败跳转到tologin
        }
    }

    @ResponseBody
    @RequestMapping("/validatecode")
    public Map validatecode(HttpSession session, String validatecode){
        Map map = new HashMap();
        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);
        if (randomCode.equalsIgnoreCase(validatecode)) {
            map.put("validatecode","true");
        }else{
            map.put("validatecode","false");
        }
        return map;
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();//清楚session
        return "redirect:/index";
    }
}
