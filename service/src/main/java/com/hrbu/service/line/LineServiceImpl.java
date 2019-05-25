package com.hrbu.service.line;

import com.hrbu.domain.Station;
import com.hrbu.domain.Train;
import com.hrbu.mapper.line.LineMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LineServiceImpl implements LineService {
    @Autowired
    private LineMapper lineMapper;

    @Override
    public String[]  selectTrain() throws Exception{
        List<Train> traList = lineMapper.selectTrain();
        String[] traId=new String[traList.size()];//列车id数组
        int count=0;
        for (Train o : traList) {
            traId[count] = o.getTraId();
            count++;
        }
        return traId;
    }

    @Override
    public String[] selectStationById(String traId) throws Exception{
        List<Station> station = lineMapper.selectStationById(traId);//需要火车id
        String[] line = new String[10];//每辆火车经过的站点
        int s=0;
        for (Station station1 : station) {
            line[s] = station1.getStationName();
            s++;
        }

        return line;
    }

    @Override
    public String[] selectTrainByStation(String stationName) throws Exception{
        List<Train> trains = lineMapper.selectTrainByStation(stationName);
        String[] train = new String[20];//数组大小随时改变
        int t = 0;                      //经过某一站的所有列车id
        for (Train train1 : trains) {
            train[t] = train1.getTraId();
            t++;
        }
        return train;
    }

    @Override
    public Train seleceTrainById(String traId) throws Exception{

        return lineMapper.seleceTrainById(traId);
    }

    @Override
    public Station selectStationByName(String stationName) throws Exception{

        return lineMapper.selectStationByName(stationName);
    }
}
