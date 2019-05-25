package com.hrbu.service.getGoods;

import com.hrbu.domain.Order;
import com.hrbu.mapper.getGoods.GetGoodsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service

public class GetGoodsServiceImpl implements GetGoodsService {
    @Autowired
    GetGoodsMapper getGoodsMapper;
    @Override
    public int selectCount(Map map) throws Exception {

        return getGoodsMapper.selectCount(map);
    }

    @Override
    public List<Order> selectOrder(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        return getGoodsMapper.selectOrder(map);
    }
}
