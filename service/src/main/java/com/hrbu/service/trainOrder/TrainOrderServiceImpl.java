package com.hrbu.service.trainOrder;

import com.hrbu.domain.Order;
import com.hrbu.mapper.trainsOrder.TrainsOrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainOrderServiceImpl implements TrainOrderService {
    @Autowired
    private TrainsOrderMapper trainsOrderMapper;

    @Override
    public List<Order> selectOrderIdByTraId(String traId) {
        return trainsOrderMapper.selectOrderIdByTraId(traId);
    }
}
