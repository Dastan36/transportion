package com.hrbu.mapper.way;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;

import java.util.List;
import java.util.Map;

public interface WayMapper {

    int selectCount(Map map) throws Exception;

    List<Train> findWayList(Map map) throws Exception;

    List<Train> selectTrain() throws Exception;

    List<Station> selectStation() throws Exception;

    void insertWay(Map map) throws Exception;
    void updateCreateWay(Map map) throws Exception;//创建线路之后 将Train 是否创建线路的标志位 值1  默认0
    void updateCreateWayDel(Map map) throws Exception; //删除线路之后 将Train 是否创建线路的标志位 值0  默认0
    List<Station> selectWayById(String traId) throws Exception;

    List<Station> selectStationById(Map map) throws Exception;

    void deleteWay(String traId) throws Exception;
}
