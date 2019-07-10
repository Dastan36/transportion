package com.hrbu.mapper.station;

import com.hrbu.domain.Station;

import java.util.List;
import java.util.Map;

public interface StationMapper {

    int selectCount(Map map) throws Exception;

    List<Station> findStationList(Map map) throws Exception;

    Station selectStationById(String stationId) throws Exception;

    String selectStationIdByName(String stationName) throws Exception;

    int saveStation(Map map) throws Exception;

    int deleteStation(String stationId) throws Exception;

    void deleteStationWay(String stationId) throws Exception;

    int updateStation(Map map) throws Exception;



}
