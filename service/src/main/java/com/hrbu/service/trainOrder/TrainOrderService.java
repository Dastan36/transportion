package com.hrbu.service.trainOrder;

import com.hrbu.domain.Order;

import java.util.List;

public interface TrainOrderService {

    List<Order> selectOrderIdByTraId(String traId);
}
