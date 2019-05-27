package com.hrbu.service.order;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.mapper.order.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<Station> selectProvince() throws Exception {
        return orderMapper.selectProvince();
    }

    @Override
    public List<Station> selectCity(String province)  throws Exception{

        return orderMapper.selectCity(province);
    }

    @Override
    public List<Station> selectStation(String city) throws Exception{

        return orderMapper.selectStation(city);
    }

    @Override
    public List<Station> selectCoordinate(List list) throws Exception{

        return orderMapper.selectCoordinate(list);
    }

    @Override
    public int selectCount(Map map) throws Exception{

        return orderMapper.selectCount(map);
    }

    @Override
    public List<Order> selectOrder(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        return orderMapper.selectOrder(map);
    }
    @Override
    public List<Order> managerSelectOrder(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        return orderMapper.managerSelectOrder(map);
    }

    @Override
    public void insertOrder(Map map) throws Exception{

        orderMapper.insertOrder(map);
    }

    @Override
    public Order selectById(String orderId) throws Exception{

        return orderMapper.selectById(orderId);
    }

    @Override
    public void updateOrder(Map map) throws Exception{

        orderMapper.updateOrder(map);
    }

    @Override
    public void updateOrderMoneyStatus(String orderId) throws Exception{

        orderMapper.updateOrderMoneyStatus(orderId);
    }

    @Override
    public void updateGetStatus(Map map) throws Exception{

        orderMapper.updateGetStatus(map);
    }

    @Override
    public void cancelOrder(String orderId) throws Exception{

        orderMapper.cancelOrder(orderId);
    }

    @Override
    public void deleteOrder(String orderId) throws Exception{

        orderMapper.deleteOrder(orderId);
    }
}
