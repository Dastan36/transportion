package com.hrbu.mapper.trainsOrder;

import com.hrbu.domain.Order;

import java.util.Map;

public interface TrainsOrderMapper {

    int insertTrainOrder(Map map);

    int deleteTrainOrder(String orderId);

    Order selectOrderIdByTraId(String traId);
}
