package com.hrbu.service.line;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;

import java.util.ArrayList;

public interface LineService {

    String[] selectTrain() throws Exception;

    String[] selectStationById(String traId) throws Exception;

    ArrayList selectTrainByStation(String stationName) throws Exception;

    Train seleceTrainById(String traId) throws Exception;

    Station selectStationByName(String stationName) throws Exception;
}
