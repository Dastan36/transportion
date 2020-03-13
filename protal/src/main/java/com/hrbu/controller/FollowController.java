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

    static String currCoordinate_l;
    static String currCoordinate_r;
    static int first = 1;

    @Autowired
    private FollowService followService;

    @RequestMapping("/tofollowprotal")
    public String toFollowProtal(){
        return "follow/follow";
    }

    @RequestMapping("/tofollowinfo")
    public String toFollow(){
        return "follow/follow_info";
    }

    @ResponseBody
    @RequestMapping("/selectStaion")
    public Map selectOrderCById(String orderId) throws Exception {
        Map map = new HashMap();
        //找到订单
        Order order = followService.selectOrderCById(orderId);
        map.put("order", order);
        List orderStationList = new ArrayList();
        orderStationList.add(order.getSenderStation());
        orderStationList.add(order.getReceiptStation());
        //找到坐标
        List<Station> stationList = followService.selectCoordinate(orderStationList);
        String coordinate_l = stationList.get(0).getCoordinate_l();
        String coordinate_r = stationList.get(0).getCoordinate_r();
        if (first == 1) {
//当前位置
            currCoordinate_l = coordinate_l;
            currCoordinate_r = coordinate_r;
            first++;
        } else {
            if (first<8){
                String[] l = {"116.74665", "117.74665", "120.74665", "119.74665", "125.74665"};
                String[] r = {"33.568801", "36.568801", "44.568801", "63.568801", "50.568801"};

                currCoordinate_l = l[first-2];
                currCoordinate_r = r[first-2];

                System.out.println(currCoordinate_l);
                System.out.println(currCoordinate_r);
                first++;
            }
        }
        System.out.println(currCoordinate_l);
        System.out.println(currCoordinate_r);
        map.put("stationList", stationList);  //起点终点数据
        map.put("currCoordinate_l", currCoordinate_l);//当前点
        map.put("currCoordinate_r", currCoordinate_r);
        return map;
    }

}
