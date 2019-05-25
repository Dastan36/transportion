package com.hrbu.service.line;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;

public interface LineService {

    String[] selectTrain() throws Exception;

    String[] selectStationById(String traId) throws Exception;

    String[] selectTrainByStation(String stationName) throws Exception;

    Train seleceTrainById(String traId) throws Exception;

    Station selectStationByName(String stationName) throws Exception;
}
