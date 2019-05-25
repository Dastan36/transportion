package com.hrbu.service.way;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;
import com.hrbu.mapper.way.WayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class WayServiceImpl implements WayService {

    @Autowired
    private WayMapper wayMapper;

    @Override
    public int selectCount(Map map) throws Exception{

        return wayMapper.selectCount(map);
    }

    @Override
    public List<Train> findWayList(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        List list = wayMapper.findWayList(map);
        return list;
    }

    @Override
    public List<Train> selectTrain() throws Exception{

        return wayMapper.selectTrain();
    }

    @Override
    public List<Station> selectStation() throws Exception{

        return wayMapper.selectStation();
    }

    @Override
    public void insertWay(Map map) throws Exception{
       // map.put("id", "66");
        wayMapper.insertWay(map);
    }

    @Override
    public void updateCreateWay(Map map)  throws Exception{

        wayMapper.updateCreateWay(map);
    }

    @Override
    public void updateCreateWayDel(Map map) throws Exception{

        wayMapper.updateCreateWayDel(map);
    }

    @Override
    public List<Station> selectWayById(String traId) throws Exception{

        return wayMapper.selectWayById(traId);
    }

    @Override
    public List<Station> selectStationById(Map map) throws Exception{

        return wayMapper.selectStationById(map);
    }

    @Override
    public void deleteWay(String traId) throws Exception{

        wayMapper.deleteWay(traId);
    }
}
