package com.hrbu.controller;

import com.hrbu.service.console.ConsoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
@RequestMapping("/console")
public class ConsoleController {

    @Autowired
    private ConsoleService consoleService;

    @ResponseBody
    @RequestMapping("/getNewNum")
    public Map getNewNum() throws Exception {
        Map map = consoleService.getNewNum();
        return map;
    }

    @ResponseBody
    @RequestMapping("/getComplaintCount")
    public Map getComplaintCount() throws Exception {
        Map complaintCount = consoleService.getCompalainCount();
        return complaintCount;
    }
}
