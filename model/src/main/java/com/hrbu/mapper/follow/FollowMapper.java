package com.hrbu.mapper.follow;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;

import java.util.List;

public interface FollowMapper {

    Order  selectOrderCById(String orderId) throws Exception;

    List<Station> selectCoordinate(List list) throws Exception;
}
