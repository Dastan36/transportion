package com.hrbu.controller;

import com.hrbu.domain.Province;
import com.hrbu.service.getGoods.GetGoodsService;
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
@RequestMapping("/getstatus")
public class GetGoodsController {
    @Autowired
    private GetGoodsService getStatusService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("/tolist")
    public String toList(){

        return "getGoods/getGoods_list";
    }

    @ResponseBody
    @RequestMapping("/getstatuslist")
    public Map statusList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "orderId",required=false) String orderId, HttpSession session) throws Exception {
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
        List orderList = getStatusService.selectOrder(map);
        int pageCount = getStatusService.selectCount(map);//总条数
        //pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
//        model.addAttribute("orderList",orderList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("orderList",orderList);
        map.put("pageCount",pageCount);
        return map;
    }


    //客户确认领货
    @ResponseBody
    @RequestMapping("/updateGetStatus")
    public boolean updateGetStatus(String getStatus,String orderId) throws Exception {
        Map map = new HashMap();
        map.put("orderId",orderId);
        map.put("getStatus",getStatus);
        map.put("getTime",new Date());
        boolean flag = false;
        flag = orderService.updateGetStatus(map);
        return flag;
    }


}
