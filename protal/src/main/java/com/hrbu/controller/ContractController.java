package com.hrbu.controller;

import com.hrbu.domain.Contract;
import com.hrbu.domain.Order;
import com.hrbu.domain.Province;
import com.hrbu.service.contract.ContractService;
import com.hrbu.service.order.OrderService;
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

@Controller
@RequestMapping("/contract")
public class ContractController {

    @Autowired
    private ContractService contractService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("/tolist")
    public String toList(){

        return "contract/contract_list";
    }

    @ResponseBody
    @RequestMapping("/orderlist")
    public Map orderList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "orderId",required=false) String orderId, HttpSession session) throws Exception {
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
        List orderList = orderService.managerSelectOrder(map);
        int pageCount = orderService.selectCount(map);//总条数
//        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("orderList",orderList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("orderList",orderList);
        map.put("pageCount",pageCount);
        return map;
    }

    @RequestMapping("/todetail")
    public String  todetail(){

        return "contract/contract_detail";
    }



    @ResponseBody
    @RequestMapping("/detail")
    public Map toDetail(Model model,String orderId) throws Exception {
        Map map = new HashMap();
        Contract contract = contractService.selectContract();
        Order order = orderService.selectById(orderId);
        map.put("contract",contract);
        map.put("order",order);
        return map;
    }

}
