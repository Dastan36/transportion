package com.hrbu.service.follow;

import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.mapper.follow.FollowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FollowServiceImpl implements FollowService {

    @Autowired
    private FollowMapper followMapper;


    @Override
    public Order selectOrderCById(String orderId) throws Exception {

        return followMapper.selectOrderCById(orderId);
    }

    @Override
    public List<Station> selectCoordinate(List list) throws Exception{

        return followMapper.selectCoordinate(list);
    }
}
