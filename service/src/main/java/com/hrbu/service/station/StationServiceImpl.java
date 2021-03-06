package com.hrbu.service.station;

import com.hrbu.domain.Station;
import com.hrbu.mapper.station.StationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class StationServiceImpl implements StationService {

    @Autowired
    private StationMapper stationMapper;

    @Override
    public int selectCount(Map map) throws Exception{

        return stationMapper.selectCount(map);
    }

    @Override
    public List<Station> findStationList(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        List stationList = stationMapper.findStationList(map);
        return stationList;
    }

    @Override
    public Station selectStationById(String stationId) throws Exception{

        return stationMapper.selectStationById(stationId);
    }

    @Override
    public String selectStationIdByName(String stationName) throws Exception {

        return stationMapper.selectStationIdByName(stationName);
    }

    @Override
    public boolean saveStation(Map map) throws Exception{
        map.put("stationId", UUID.randomUUID().toString());
        int count = stationMapper.saveStation(map);
        return count>0;
    }

    @Override
    public boolean deleteStation(String stationId) throws Exception{
        stationMapper.deleteStationWay(stationId);
        int count = stationMapper.deleteStation(stationId);
        return count>0;
    }

    @Override
    public boolean updateStation(Map map) throws Exception{

        int count = stationMapper.updateStation(map);
        return count>0;
    }


}
