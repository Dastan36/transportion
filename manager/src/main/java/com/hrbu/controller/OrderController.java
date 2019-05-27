package com.hrbu.controller;

import com.hrbu.domain.Order;
import com.hrbu.domain.Province;
import com.hrbu.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping("/orderlist")
    public String orderList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr,@RequestParam(value = "orderId",required=false) String orderId, HttpSession session) throws Exception {
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
        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        model.addAttribute("orderList",orderList);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageCount",pageCount);
        return "order/order_list";
    }

    @RequestMapping("/toupdate")
    public String toUpdate(Model model,String orderId) throws Exception {
        Order order = orderService.selectById(orderId);
        model.addAttribute("order",order);
        return "order/order_update";
    }

    //更新订单状态
    @RequestMapping("update")
    public String update(String status,String getStatus,String orderId,String lineMatch) throws Exception {
        Map map = new HashMap();
        map.put("status",status);
        map.put("lineMatch",lineMatch);
        map.put("orderId",orderId);
        orderService.updateOrder(map);
        if("已完成".equals(status)){
            map.put("getStatus",getStatus);
            map.put("arriveTime",new Date());
            if ("已领货".equals(getStatus)){
                map.put("getTime",new Date());
            }
            orderService.updateGetStatus(map);
        }
        return "redirect:/order/orderlist";
    }


    @RequestMapping("/print")
    @ResponseBody
    public Order print(String orderId) throws Exception {

        Order order = orderService.selectById(orderId);

        return order;
    }



}
