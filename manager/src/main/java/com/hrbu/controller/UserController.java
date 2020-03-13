package com.hrbu.controller;

import com.hrbu.domain.User;
import com.hrbu.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/tolist")
    public String toList(){

        return "user/user_list";
    }

    @ResponseBody
    @RequestMapping("/userlist")
    public Map findUserList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(required=false)String userName,@RequestParam(required=false)String telephone) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        Map map = new HashMap();          //get到查询条件
        map.put("pageNum",pageNum);
        map.put("userName",userName);
        map.put("telephone",telephone);
        List userList = userService.selectUser(map);
        int pageCount = userService.selectCount(map);//总条数
        //pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("userList",userList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("userList",userList);
        map.put("pageCount",pageCount);

        return map;
    }

    @RequestMapping("/toadd")
    public String toAdd(){

        return "user/user_add";
    }

    @ResponseBody
    @RequestMapping("saveuser")
    public boolean saveUser(User user) throws Exception {
        user.setUserId(UUID.randomUUID().toString());
        user.setCreateTime(new Date());
        boolean flag = false;
        flag = userService.saveUser(user);
        return flag;
    }



    @RequestMapping("/toupdate")
    public String toUpdate(Model model, @RequestParam("userId")String userId) throws Exception {
        User user = userService.toUpdate(userId);
        model.addAttribute("user",user);
        return "user/user_update";
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(User user) throws Exception {
        boolean flag = false;
        flag = userService.update(user);
        return flag;
    }

    @RequestMapping("/delete")
    @ResponseBody                                //ajax 传参删除
    public Map delete(@RequestParam("userId") String userId) throws Exception {
        Map map = new HashMap();
        userService.deleteUser(userId);
        map.put("success",true);
        return map;
    }





}
