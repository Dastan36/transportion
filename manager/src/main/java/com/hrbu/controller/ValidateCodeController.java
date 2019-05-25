package com.hrbu.controller;

import com.hrbu.sysfranework.validateCode.ValidateCode;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@Controller
@RequestMapping("/validatecode")
public class ValidateCodeController {


    @RequestMapping(value="/show")
    public void checkCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //设置相应类型,告诉浏览器输出的内容为图片
        response.setContentType("image/jpeg");

        //设置响应头信息，告诉浏览器不要缓存此内容
        response.setHeader("pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expire", 0);
        ValidateCode validateCode = new ValidateCode();
        try {
            validateCode.getRandcode(request, response);//输出图片方法   //调用之前在ValidateCode Session.setAtt  key = RANDOMCODEKEY

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}