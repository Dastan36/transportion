package com.hrbu.service.compensate;

import com.hrbu.domain.Compensate;
import com.hrbu.domain.Order;
import com.hrbu.mapper.compensate.CompensateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CompensateServiceImpl implements CompensateService {

    @Autowired
    private CompensateMapper compensateMapper;
    @Override
    public int selectCount(Map map) throws Exception {

        return compensateMapper.selectCount(map);
    }

    @Override
    public List<Compensate> selectCompensate(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        return compensateMapper.selectCompensate(map);
    }

    @Override
    public List<Order> compensateVerifyOrderId(String orderId) throws Exception{
        return compensateMapper.compensateVerifyOrderId(orderId);
    }

    @Override
    public boolean insertCompensate(Map map) throws Exception{

        int count = compensateMapper.insertCompensate(map);
        return count>0;
    }

    @Override
    public Order selectCompensateById(String orderId) throws Exception {

        return compensateMapper.selectCompensateById(orderId);
    }

    @Override
    public boolean cancel(String orderId) throws Exception {
        int count = compensateMapper.cancel(orderId);
        return count>0;
    }

    @Override
    public boolean updateCompensate(Map map) throws Exception {
        int count = compensateMapper.updateCompensate(map);
        return count>0;
    }

    @Override
    public String selectMoneyById(String orderId) throws Exception {

        return compensateMapper.selectMoneyById(orderId);
    }
}
