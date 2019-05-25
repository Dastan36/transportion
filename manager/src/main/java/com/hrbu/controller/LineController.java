package com.hrbu.controller;


import com.hrbu.domain.Train;
import com.hrbu.service.line.LineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

import static com.hrbu.sysfranework.stationIndex.StationIndex.printArray;

@Controller
@RequestMapping("/line")
public class LineController {

    //http://localhost:8080/transportion/manager/line/test
    @Autowired
    private LineService lineService;

    @ResponseBody
    @RequestMapping("/match")  //匹配
    public List match(String senderStation,String receiptStation) throws Exception {
        List list = new ArrayList();

        String startStation = senderStation;
        String endStation = receiptStation;

        //判断是否有直达   完成
        String[] traId = lineService.selectTrain();//列车id
        String[] line_temp = new String[5];  //直达列车
        int count = 0;
        for(int i = 0;i<traId.length;i++) {
            int directFlag = 0;//直达标志
            String[] line = lineService.selectStationById(traId[i]);//每辆车的路线
            for (int k = 0; k < line.length; k++) {
                if (startStation.equals(line[k])){          //先判断起点 有起点 在判断起点之后有没有终点  按顺序判断（和车的来回走向有关）
                    directFlag++;
                    for(int j = k;j<line.length;j++){
                        if (endStation.equals(line[j]))
                            directFlag++;
                    }

                }

                if (directFlag == 2) {
                    //System.out.println(traId[i]);
                    //System.out.println("有直达");
                    line_temp[i] = traId[i];
                    count++;
                    directFlag = 0;
                }
            }
        }
            for(int j = 0;j<line_temp.length;j++)
                if(line_temp[j] != null){
                    Train train = lineService.seleceTrainById(line_temp[j]);
                    System.out.println(train.getTraName());
                    list.add(train.getTraName());
                }

                //System.out.println(line_temp[j]);



        //没有直达
        if(count == 0){
            String[] station_temp = new String[5];
            int sss = 0;
            //经过始末点的所有列车id
            String start_pass[] = lineService.selectTrainByStation(startStation);
            String end_pass[] = lineService.selectTrainByStation(endStation);
            for(int s = 0;s<start_pass.length;s++){
                for(int e = 0;e<end_pass.length;e++) {
                    if (start_pass[s] != null && end_pass[e] != null) {
                        String[] start_pass_line = lineService.selectStationById(start_pass[s]);//经过点的车的线路
                        int startIndex = printArray(start_pass_line,startStation);
                        String[] end_pass_line = lineService.selectStationById(end_pass[e]);
                        int endIndex = printArray(end_pass_line,endStation);
                        for (int ss = startIndex; ss < start_pass_line.length; ss++)
                            for (int ee = 0; ee <=endIndex; ee++) {
                                if(start_pass_line[ss] != null && end_pass_line[ee] != null)
                                    if (start_pass_line[ss].equals(end_pass_line[ee])) {
                                        Train first_line = lineService.seleceTrainById(start_pass[s]);
                                        Train second_line = lineService.seleceTrainById(end_pass[e]);
//                                        String first_line = start_pass[s];
//                                        String second_line = end_pass[e];
                                        String change_station = start_pass_line[ss];
                                        station_temp[sss] = first_line.getTraName() + change_station + second_line.getTraName();
                                        sss++;
                                    }
                            }
                    }

                }
            }
            if(station_temp.length>0) {
                for (int i = 0; i < station_temp.length; i++) {
                    if (station_temp[i] != null){
                        System.out.println("乘车路线如下：\n" + station_temp[i]);
                        list.add(station_temp[i]);
                    }
                }
            }

        }


        return list;

    }
}
