package com.hrbu.service.order;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.mapper.compensate.CompensateMapper;
import com.hrbu.mapper.complaint.ComplaintMapper;
import com.hrbu.mapper.order.OrderMapper;
import com.hrbu.mapper.trainsOrder.TrainsOrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private ComplaintMapper complaintMapper;
    @Autowired
    private CompensateMapper compensateMapper;
    @Autowired
    private TrainsOrderMapper trainsOrderMapper;

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
    public boolean updateOrder(Map map) throws Exception{

        int count = orderMapper.updateOrder(map); //更新订单 线路 状态

        if (map.get("traId") != null && map.get("traId") != ""){  //等于null时 说明 1.没有选择匹配的列车 或者 2.已选择没有重新选择    此时不需要添加数据
            trainsOrderMapper.deleteTrainOrder((String) map.get("orderId"));//先删除t_trains_order 中这个orderId原有的记录  1.数据库没有相关数据  2.有相关数据
            trainsOrderMapper.insertTrainOrder(map);   //添加 traId orderId t_trains_order
        }

        return count > 0;
    }

    @Override
    public void updateOrderMoneyStatus(String orderId) throws Exception{

        orderMapper.updateOrderMoneyStatus(orderId);
    }

    @Override
    public boolean updateGetStatus(Map map) throws Exception{

        int count = orderMapper.updateGetStatus(map);
        return count>0;
    }

    @Override
    public boolean cancelOrder(String orderId) throws Exception{
        complaintMapper.cancelComplaint(orderId);
        compensateMapper.cancel(orderId);
        int count = orderMapper.cancelOrder(orderId);
        return count>0;
    }

    @Override
    public boolean deleteOrder(String orderId) throws Exception{
        complaintMapper.cancelComplaint(orderId);
        compensateMapper.cancel(orderId);
        int count = orderMapper.deleteOrder(orderId);
        return count>0;
    }
}
