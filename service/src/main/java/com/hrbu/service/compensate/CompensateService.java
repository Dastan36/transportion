package com.hrbu.service.compensate;

import com.hrbu.domain.Compensate;
import com.hrbu.domain.Order;

import java.util.List;
import java.util.Map;

public interface CompensateService {

    int selectCount(Map map) throws Exception;

    List<Compensate> selectCompensate(Map map) throws Exception;

    List<Order> compensateVerifyOrderId(String orderId) throws Exception;

    boolean insertCompensate(Map map) throws Exception;

    Order selectCompensateById(String orderId) throws Exception;

    boolean cancel(String orderId) throws Exception;

    boolean updateCompensate(Map map) throws Exception;

    String selectMoneyById(String orderId) throws Exception;
}
