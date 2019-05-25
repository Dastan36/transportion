package com.hrbu.service.follow;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;

import java.util.List;


public interface FollowService {

    Order selectOrderCById(String orderId) throws Exception;

    List<Station> selectCoordinate(List list) throws Exception;

}
