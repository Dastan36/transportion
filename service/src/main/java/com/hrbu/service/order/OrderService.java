package com.hrbu.service.order;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;

import java.util.List;
import java.util.Map;

public interface OrderService {

    //订单 三级联动
    List<Station> selectProvince() throws Exception;

    List<Station> selectCity(String province) throws Exception;

    List<Station> selectStation(String city) throws Exception;

    List<Station> selectCoordinate(List list) throws Exception;

    int selectCount(Map map) throws Exception;

    List<Order> selectOrder(Map map) throws Exception;
    List<Order> managerSelectOrder(Map map) throws Exception;

    void insertOrder(Map map) throws Exception;

    Order selectById(String orderId) throws Exception;

    boolean updateOrder(Map map) throws Exception;

    //在线支付 更改订单状态
    void updateOrderMoneyStatus(String orderId) throws Exception;

    boolean updateGetStatus(Map map) throws Exception;

    //取消订单
    boolean  cancelOrder(String orderId) throws Exception;

    //删除 控制显示
    boolean deleteOrder(String orderId) throws Exception;
}
