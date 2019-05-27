package com.hrbu.controller;

import com.hrbu.domain.Order;
import com.hrbu.domain.Province;
import com.hrbu.service.complaint.ComplaintService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/complaint")
public class ComplaintController {

    @Autowired
    private ComplaintService complaintService;

    @RequestMapping("/complaintlist")
    public String complaintList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "orderId",required=false) String orderId, HttpSession session) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        Object userId = session.getAttribute("userId");

        Map map = new HashMap();
        map.put("pageNum",pageNum);
        map.put("userId",userId);
        map.put("orderId",orderId);

        List complaintList = complaintService.selectComplaint(map);
        int pageCount = complaintService.selectCount(map);//总条数
        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        model.addAttribute("complaintList",complaintList);//因为主外键关系  order--->complaint
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageCount",pageCount);
        return "complaint/complaint_list";
    }

    @RequestMapping("/cancel")
    @ResponseBody
    public Map cancel(String complaintId) throws Exception {
        Map map = new HashMap();
        complaintService.cancelComplaint(complaintId);
        map.put("success",true);
        return map;
    }

    @RequestMapping("/tocreate")
    public String tocreate(){

        return "complaint/complaint_add";
    }


    //complaintId,orderId,userId,complaintType,complaintName,complaintDescribe,createTime
    @RequestMapping("/add")
    public String add(HttpSession session,String orderId,String complaintType,String complaintPhone,
                      String complaintName,String complaintDescribe) throws Exception {
        Map map = new HashMap();
        map.put("complaintId", UUID.randomUUID().toString());
        map.put("orderId",orderId);
        map.put("userId",session.getAttribute("userId"));
        map.put("complaintType",complaintType);
        map.put("complaintName",complaintName);
        map.put("complaintPhone",complaintPhone);
        map.put("complaintDescribe",complaintDescribe);
        map.put("createTime",new Date());
        complaintService.insertComplaint(map);
        return "redirect:/complaint/complaintlist";
    }

    @RequestMapping("/todetails")
    public String toDetails(Model model,String complaintId) throws Exception {
        Order order = complaintService.selectDetails(complaintId);
        model.addAttribute("complaint",order);
        return "complaint/complaint_details";
    }

    @RequestMapping("/complaintVerifyOrderId")
    @ResponseBody
    public Map complaintVerifyOrderId(String orderId) throws Exception {
        Order order = complaintService.complaintVerifyOrderId(orderId);
        Map map = new HashMap();
        if (order == null){
            map.put("order",null);
        }else{
            map.put("order",order);
        }

        return map;
    }



}
