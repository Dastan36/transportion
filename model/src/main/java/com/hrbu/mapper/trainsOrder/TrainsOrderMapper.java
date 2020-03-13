package com.hrbu.mapper.trainsOrder;

import com.hrbu.domain.Order;

import java.util.List;
import java.util.Map;

public interface TrainsOrderMapper {

    int insertTrainOrder(Map map);

    int deleteTrainOrder(String orderId);

    List<Order> selectOrderIdByTraId(String traId);
}
