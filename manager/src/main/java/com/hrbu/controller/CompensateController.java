package com.hrbu.controller;

import com.hrbu.domain.Complaint;
import com.hrbu.domain.Order;
import com.hrbu.domain.Province;
import com.hrbu.service.compensate.CompensateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/compensate")
public class CompensateController {
    @Autowired
    private CompensateService compensateService;

    @RequestMapping("/tolist")
    public String toList(){

        return "compensate/compensate_list";
    }

    @ResponseBody
    @RequestMapping("/compensatelist")
    public Map complaintList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "orderId",required=false) String orderId, HttpSession session) throws Exception {
        int pageNum = 1;    //分页 第几页

        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        Object userId = session.getAttribute("userId");
        List<Province> provinces = (List<Province>) session.getAttribute("provinces");
        Map map = new HashMap();
        map.put("pageNum",pageNum);
        map.put("userId",userId);
        map.put("orderId",orderId);
        map.put("provinces",provinces);
        List compensateList = compensateService.selectCompensate(map);
        int pageCount = compensateService.selectCount(map);//总条数
//        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("compensateList",compensateList);//因为主外键关系  order--->complaint
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("compensateList",compensateList);
        map.put("pageCount",pageCount);
        return map;
    }

    @RequestMapping("/tocreate")
    public String toCreate(){

        return "compensate/compensate_create";
    }

    //验证订单号是否可理赔
    @RequestMapping("/compensateVerifyOrderId")
    @ResponseBody
    public Map compensateVerifyOrderId(String orderId) throws Exception {
        List<Order> order = compensateService.compensateVerifyOrderId(orderId);//判断订单号在投诉模块中的投诉状态，可理赔
        Map map = new HashMap();
        if (order.size() == 0){
            map.put("order","null");
        }else{
            for (Order order1 : order) {
                for (Complaint complaint : order1.getComplaint()) {
                    if ("可理赔".equals(complaint.getStatus())){//投诉状态 是否是可理赔
                        map.put("order","true");
                        break;
                    }
                }
            }
        }
        return map;
    }

    @RequestMapping("/compensateVerify")
    @ResponseBody
    public Map compensateVerify(String orderId) throws Exception {
        Map map = new HashMap();
        Order order = compensateService.selectCompensateById(orderId);
        if (order == null){
            map.put("compensate","false");
        }else{
            map.put("compensate","true");
        }
        return map;
    }

    @ResponseBody
    @RequestMapping("/create")
    public boolean  create(HttpSession session,String orderId,String compensateName,String compensateMoney) throws Exception {
        Map map = new HashMap();
        map.put("compensateId", UUID.randomUUID().toString());
        map.put("orderId",orderId);
        map.put("userId",session.getAttribute("userId"));
        map.put("compensateName",compensateName);
        map.put("compensateMoney",compensateMoney);
        map.put("compensateTime",new Date());
        // compensateStatus 理赔状态默认 处理中
        boolean flag = false;
        flag = compensateService.insertCompensate(map);
        return flag;
    }

    @ResponseBody
    @RequestMapping("/cancel")
    public Map cancel(String orderId) throws Exception {
        Map map = new HashMap();
        boolean success = false;
        success = compensateService.cancel(orderId);
        map.put("success",success);
        return  map;
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(String orderId,String compensateMoney,String compensateStatus) throws Exception {
        Map map = new HashMap();
        map.put("orderId",orderId);
        map.put("compensateMoney",compensateMoney);
        map.put("compensateStatus",compensateStatus);
        boolean flag = false;
        if("已理赔".equals(compensateStatus)){

            flag = compensateService.updateCompensate(map);
        }
//        if (flag){
//            return "redirect:/ali/torefundpart?orderId="+orderId;
//        }
//        return "redirect:/compensate/compensatelist";
        return flag;
    }
}
