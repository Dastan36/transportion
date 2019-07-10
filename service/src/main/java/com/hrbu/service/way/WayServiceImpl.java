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
    public boolean insertWay(Map map) throws Exception{
       // map.put("id", "66");
        int count = wayMapper.insertWay(map);
        return count>0;
    }

    @Override
    public boolean updateCreateWay(Map map)  throws Exception{

        int count = wayMapper.updateCreateWay(map);
        return count>0;
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
    public boolean deleteWay(String traId) throws Exception{

        int count = wayMapper.deleteWay(traId);
        return count>0;
    }

    @Override
    public Station selectTimeByStationIdAndTrainId(Map map) throws Exception {
        Station station = wayMapper.selectTimeByStationIdAndTrainId(map);
        return station;
    }
}
