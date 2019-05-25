package com.hrbu.controller;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.service.follow.FollowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/follow")
public class FollowController {

    @Autowired
    private FollowService followService;

    @RequestMapping("/tosearch")
    public String toSearch(){
        return "follow/follow_search";
    }


    @ResponseBody
    @RequestMapping("/selectStaion")
    public Map selectOrderCById(String orderId) throws Exception {
        Map map = new HashMap();
        Order order = followService.selectOrderCById(orderId);
        map.put("order",order);
        List orderStationList = new ArrayList();
        orderStationList.add(order.getSenderStation());
        orderStationList.add(order.getReceiptStation());
        List<Station> stationList = followService.selectCoordinate(orderStationList);
        map.put("stationList",stationList);
        return map;
    }
}
