package com.hrbu.service.station;

import com.hrbu.domain.Station;

import java.util.List;
import java.util.Map;

public interface StationService {
    int selectCount(Map map)throws Exception;

    List<Station> findStationList(Map map) throws Exception;

    Station selectStationById(String stationId) throws Exception;

    String selectStationIdByName(String stationName) throws Exception;

    boolean saveStation(Map map) throws Exception;

    boolean deleteStation(String stationId) throws Exception;

    boolean updateStation(Map map) throws Exception;
}
