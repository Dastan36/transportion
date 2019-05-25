package com.hrbu.service.getGoods;

import com.hrbu.domain.Order;

import java.util.List;
import java.util.Map;

public interface GetGoodsService {

    int selectCount(Map map) throws Exception;

    List<Order> selectOrder(Map map) throws Exception;

}
