package com.hrbu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/protal")
public class ProtalController {

    @RequestMapping(value={"/","index"})
    public String  home(){

        return "homejsp/index";
    }
}
