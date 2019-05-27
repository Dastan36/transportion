package com.hrbu.controller;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;


@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    //三级联动 火车站 城市  省份
    @RequestMapping("/orderinfo")
    public String orderInfo(Model model) throws Exception {
        //List cityList = orderService.selectCity();
        List provinceList = orderService.selectProvince();
        model.addAttribute("provinceList", provinceList);
        return "order/order_info";
    }

    //三级联动 火车站 城市 门户order
    @RequestMapping("/protalorder")
    public String protalorder(Model model) throws Exception {
        List provinceList = orderService.selectProvince();
        model.addAttribute("provinceList", provinceList);
        return "order/order";
    }

    @RequestMapping("/citystation")
    @ResponseBody
    public Map cityStation(String city) throws Exception {
        List stationList = orderService.selectStation(city);
        Map map = new HashMap();
        map.put("stationList", stationList);
        return map;
    }

    @RequestMapping("/provincecity")
    @ResponseBody
    public Map provinceCity(String province) throws Exception {
        List cityList = orderService.selectCity(province);
        Map map = new HashMap();
        map.put("cityList", cityList);
        return map;
    }

    @RequestMapping("/selectCoordinate")
    @ResponseBody
    public Map selectCoordinate(String senderStationName, String receiptStationName) throws Exception {
        Map map = new HashMap();
        List list = new ArrayList();
        list.add(senderStationName);
        list.add(receiptStationName);
        List<Station> stationList = orderService.selectCoordinate(list);
        map.put("stationList", stationList);
        return map;
    }

    @RequestMapping("/orderlist")
    public String orderList(Model model, @RequestParam(value = "pageNum", required = false) String pageNumStr, @RequestParam(value = "orderId", required = false) String orderId, HttpSession session) throws Exception {
        int pageNum = 1;    //分页 第几页

        if (pageNumStr != null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }

        Object userId = session.getAttribute("userId");
        Map map = new HashMap();
        map.put("pageNum", pageNum);
        map.put("userId", userId);
        map.put("orderId", orderId);
        List orderList = orderService.selectOrder(map);
        int pageCount = orderService.selectCount(map);//总条数
        pageCount = (pageCount % 9 == 0) ? (pageCount / 9) : ((pageCount / 9) + 1);//页数  每页显示9条
        model.addAttribute("orderList", orderList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("pageCount", pageCount);
        return "order/order_list";
    }


    @RequestMapping("/insert")  //center 订单
    public String insertOrder(HttpSession session, String senderName, String senderPhone, String senderProvince, String senderStation,
                              String receiptName, String receiptPhone, String receiptProvince, String receiptStation,
                              String goodsName, Double goodsWeight, Double goodsVolume, String money, String moneyStatus, Date transTime) throws Exception {
        Map map = new HashMap();
        map.put("orderId", UUID.randomUUID().toString());
        map.put("userId", session.getAttribute("userId"));
        map.put("senderName", senderName);
        map.put("senderPhone", senderPhone);
        map.put("senderProvince", senderProvince);
        map.put("senderStation", senderStation);
        map.put("receiptName", receiptName);
        map.put("receiptPhone", receiptPhone);
        map.put("receiptProvince", receiptProvince);
        map.put("receiptStation", receiptStation);
        map.put("goodsName", goodsName);
        map.put("goodsWeight", goodsWeight);
        map.put("goodsVolume", goodsVolume);
        map.put("money", money);
        map.put("moneyStatus", moneyStatus);
        map.put("transTime", transTime);
        map.put("createTime", new Date());
        orderService.insertOrder(map);
        return "redirect:/order/orderlist";
    }

    @RequestMapping("/insertprotal")  //门户订单
    public String insertOrderProtal(HttpSession session, String senderName, String senderPhone, String senderProvince, String senderStation,
                                    String receiptName, String receiptPhone, String receiptProvince, String receiptStation,
                                    String goodsName, Double goodsWeight, Double goodsVolume, String money, String moneyStatus, Date transTime) throws Exception {
        Map map = new HashMap();
        map.put("orderId", UUID.randomUUID().toString());
        map.put("userId", session.getAttribute("userId"));
        map.put("senderName", senderName);
        map.put("senderPhone", senderPhone);
        map.put("senderProvince", senderProvince);
        map.put("senderStation", senderStation);
        map.put("receiptName", receiptName);
        map.put("receiptPhone", receiptPhone);
        map.put("receiptProvince", receiptProvince);
        map.put("receiptStation", receiptStation);
        map.put("goodsName", goodsName);
        map.put("goodsWeight", goodsWeight);
        map.put("goodsVolume", goodsVolume);
        map.put("money", money);
        map.put("moneyStatus", moneyStatus);
        map.put("transTime", transTime);
        map.put("createTime", new Date());
        orderService.insertOrder(map);
        return "center";
    }

    @RequestMapping("/cancel")
    @ResponseBody
    public Map cancel(String orderId) throws Exception {
        orderService.cancelOrder(orderId);
        Map map = new HashMap();
        map.put("success", true);
        return map;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(String orderId) throws Exception {
        orderService.deleteOrder(orderId);
        Map map = new HashMap();
        map.put("success", true);
        return map;
    }

    @RequestMapping("/print")
    @ResponseBody
    public Order print(String orderId) throws Exception {

        Order order = orderService.selectById(orderId);

        return order;
    }


    //点击付款状态 保留订单的情况下 进行在线付款
    @RequestMapping("/toupdatemmonystatus")
    public String toUpdateMoneyStatus(Model model, String orderId) throws Exception {
        Order order = orderService.selectById(orderId);
        model.addAttribute("order", order);
        return "order/order_pay";
    }
}
