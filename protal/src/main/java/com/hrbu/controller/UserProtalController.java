package com.hrbu.controller;

import com.hrbu.domain.User;
import com.hrbu.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.hrbu.sysfranework.validate.ValidateCode.RANDOMCODEKEY;

@Controller
@RequestMapping("/user")
public class UserProtalController {

    @Autowired
    private UserService userService;

    @RequestMapping("/userinfo")
    public String userInfo(HttpSession session,Model model) throws Exception {
        String userId = (String) session.getAttribute("userId");
        User user = userService.findUserById(userId);
        model.addAttribute("user",user);
        session.setAttribute("user",user);
        return "user/user_info";
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(User user) throws Exception {
        boolean flag = false;
        flag = userService.update(user);
        return flag;
    }

    @RequestMapping("/toupdatepassword")
    public String toUpdatePassword(){

        return "user/user_update_pass";
    }


    //修改密码
    @ResponseBody
    @RequestMapping("/updatepassword")
    public boolean updatePassword(@RequestParam(value = "newPassword") String password, String userId) throws Exception {
        Map map = new HashMap();
        map.put("password",password);
        map.put("userId",userId);
        boolean flag = false;
        flag = userService.updatePassword(map);
        //return "redirect:/user/userinfo?userId="+userId;
        return flag;
    }

    //验证验证码
    @ResponseBody
    @RequestMapping("/validatecode")
    public Map validatecode(HttpSession session, String validatecode){
        Map map = new HashMap();
        String randomCode = (String) session.getAttribute(RANDOMCODEKEY);
        if (randomCode.equalsIgnoreCase(validatecode)) {
            map.put("validatecode",true);
        }else{
            map.put("validatecode",false);
        }
        return map;
    }

    //验证旧密码
    @ResponseBody
    @RequestMapping("/validateoldpass")
    public Map validateOldPass(String userId) throws Exception {
        Map map = new HashMap();
        User user = userService.findUserById(userId);
        String oldPas = user.getPassword();
        map.put("oldPas",oldPas);
        return map;
    }

    @ResponseBody
    @RequestMapping("/verifyphone")
    public Map verifyPhone(String userId) throws Exception {
        Map map = new HashMap();
        List<User> user = userService.verifyPhone(userId);
        if(user.size() == 0){
            map.put("user","true");
        }else{
            map.put("user","false");
        }
        return map;
    }

}
