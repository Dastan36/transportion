package com.hrbu.mapper.line;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;

import java.util.List;

public interface LineMapper {

    List<Train> selectTrain() throws Exception;

    List<Station> selectStationById(String traId) throws Exception;

    List<Train> selectTrainByStation(String stationName) throws Exception;

    Train seleceTrainById(String traId) throws Exception;

    Station selectStationByName(String stationName) throws Exception;

}
