package com.hrbu.service.way;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;

import java.util.List;
import java.util.Map;

public interface WayService {

    int selectCount(Map map) throws Exception;

    List<Train> findWayList(Map map) throws Exception;

    List<Train> selectTrain() throws Exception;

    List<Station> selectStation() throws Exception;

    void insertWay(Map map) throws Exception;
    void updateCreateWay(Map map) throws Exception;
    void updateCreateWayDel(Map map) throws Exception;

    List<Station> selectWayById(String traId) throws Exception;

    List<Station> selectStationById(Map map) throws Exception;

    void deleteWay(String traId) throws Exception;
}
