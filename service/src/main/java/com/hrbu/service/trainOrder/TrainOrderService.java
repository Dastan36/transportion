package com.hrbu.service.trainOrder;

import com.hrbu.domain.Order;

public interface TrainOrderService {

    Order selectOrderIdByTraId(String traId);
}
