package com.hrbu.controller;


import com.hrbu.domain.User;
import com.hrbu.service.register.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

import static com.hrbu.sysfranework.validate.ValidateCode.RANDOMCODEKEY;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private RegisterService registerService;

    @RequestMapping("/toregister")
    public String toRegister(){

        return "register/register";
    }

    @RequestMapping("/register")
    public String register(HttpSession session, User user, String validatecode) throws Exception {

        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);

        user.setUserId(UUID.randomUUID().toString());
        user.setCreateTime(new Date());
        if (randomCode.equalsIgnoreCase(validatecode)) {
            if (registerService.register(user)) {
                return "redirect:/touserlogin";  //验证成功跳转到center
            }else{
                return "redirect:/register/toregister";
            }
        } else {
            session.setAttribute("registerMsg", "验证码错误");
            return "redirect:/register/toregister";  //验证失败跳转到tologin
        }
    }

    @ResponseBody
    @RequestMapping("/verifyphone")
    public Map verifyPhone(String telephone) throws Exception {
        Map map = new HashMap();
        List<User> user = registerService.verifyPhone(telephone);
        if(user.size() == 0){
            map.put("user",null);
        }else{
            map.put("user",user);
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/validatecode")
    public Map validatecode(HttpSession session,String validatecode){
        Map map = new HashMap();
        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);
        if (randomCode.equalsIgnoreCase(validatecode)) {
            map.put("validatecode",true);
        }else{
            map.put("validatecode",false);
        }
        return map;
    }

}
