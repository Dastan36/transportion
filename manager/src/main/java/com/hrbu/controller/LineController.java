package com.hrbu.controller;


import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.domain.Train;
import com.hrbu.service.line.LineService;
import com.hrbu.service.station.StationService;
import com.hrbu.service.trainOrder.TrainOrderService;
import com.hrbu.service.way.WayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

import static com.hrbu.sysfranework.stationIndex.LineMatchUtil.*;

@Controller
@RequestMapping("/line")
public class LineController {


    //http://localhost:8080/transportion/manager/line/test
    @Autowired
    private LineService lineService;
    @Autowired
    private StationService stationService;
    @Autowired
    private WayService wayService;
    @Autowired
    private TrainOrderService trainOrderService;

    @ResponseBody
    @RequestMapping("/match")  //匹配
    public List match(String senderStation, String receiptStation,String goodsWeight,String goodsVolume) throws Exception {
        List list = new ArrayList();
        List traIdList = new ArrayList();
//此订单
        String startStation = senderStation; //起始站
        String endStation = receiptStation; //终点站
        String startStationId = stationService.selectStationIdByName(senderStation); //起始站ID
        String endStationId = stationService.selectStationIdByName(receiptStation); //终点站ID

        String weight = goodsWeight;//货物重量
        String volume = goodsVolume;//货物体积

        //判断是否有直达   完成
        String[] traId = lineService.selectTrain();//列车id数组
        String[] line_temp = new String[10];  //直达列车
        int count = 0;
        for (int i = 0; i < traId.length; i++) {
            int directFlag = 0;//直达标志
            String[] line = lineService.selectStationById(traId[i]);//每辆车的路线  路线上的站点数组
            for (int k = 0; k < line.length; k++) {
                if (startStation.equals(line[k])) {          //先判断起点 有起点directFlag=1 在判断起点之后有没有终点  按顺序判断（和车的来回走向有关）
                    directFlag++;
                    for (int j = k; j < line.length; j++) {
                        if (endStation.equals(line[j]))     //判断终点站 有终点directFlag=2
                            directFlag++;
                    }

                }

                if (directFlag == 2) {
                    //System.out.println(traId[i]);
                    System.out.println("直达");
                    line_temp[i] = traId[i];  //直达车的id
                    //count++;
                    directFlag = 0;
                }
            }
        }
        for (int j = 0; j < line_temp.length; j++)
            if (line_temp[j] != null) {
                Train train = lineService.seleceTrainById(line_temp[j]);   //直达车
                System.out.println(train.getTraName());
                traIdList.add(train.getTraId());  //记录一下列车的id

                Map startWayMap = new HashMap();
                startWayMap.put("stationId", startStationId);
                startWayMap.put("traId", train.getTraId());
                Station startStationTime = wayService.selectTimeByStationIdAndTrainId(startWayMap);
                Map endWayMap = new HashMap();
                endWayMap.put("stationId", endStationId);
                endWayMap.put("traId", train.getTraId());
                Station endStationTime = wayService.selectTimeByStationIdAndTrainId(endWayMap);

                Date outTime = startStationTime.getWay().getOutTime();//出发站 出站时间
                Date inTime = endStationTime.getWay().getInTime();  //末站 进站时间
                long l = printDateLong(outTime,inTime);  //shijian
                System.out.println(printDate(l));

                //运力
                Order order = trainOrderService.selectOrderIdByTraId(train.getTraId());//这辆列车上的订单
                //order.getReceiptStation();


                Map map = new HashMap();
                map.put("type","直达");
                map.put("traId",train.getTraId());
                map.put("traName",train.getTraName());
                map.put("outTime",outTime);
                map.put("inTime",inTime);
                map.put("time",printDate(l));
                map.put("startStation",startStation);
                map.put("endStation",endStation);
                list.add(map);
                //list.add(train.getTraName()+printDate(l));
            }

        //System.out.println(line_temp[j]);


        /**
         * 没有直达  转车
         */


            int sss = 0;
            //经过始末点的所有列车id
            ArrayList<String> start_pass = lineService.selectTrainByStation(startStation);
            ArrayList<String> end_pass = lineService.selectTrainByStation(endStation);
            //删除直达的车id
        for (Object o : traIdList) {
            if (start_pass.contains(o)){
                start_pass.remove(o);
            }
            if (end_pass.contains(o)){
                end_pass.remove(o);
            }
        }
            for (int s = 0; s < start_pass.size(); s++) {
                for (int e = 0; e < end_pass.size(); e++) {
                    if (start_pass.get(s) != null && end_pass.get(e) != null) {
                        String[] start_pass_line = lineService.selectStationById(start_pass.get(s));//所有经过始末站点的 车的线路站点数组
                        int startIndex = printArray(start_pass_line, startStation);   //得出始末站点在一辆车的线路数组中的位置index
                        String[] end_pass_line = lineService.selectStationById(end_pass.get(e));
                        int endIndex = printArray(end_pass_line, endStation);
                        for (int ss = startIndex+1; ss < start_pass_line.length; ss++)    //从index处开始循环   有顺序
                            for (int ee = 0; ee < endIndex; ee++) {
                                if (start_pass_line[ss] != null && end_pass_line[ee] != null)
                                    if (start_pass_line[ss].equals(end_pass_line[ee])) {       //两辆车的线路有交叉点  （中转站）
                                        Train first_line = lineService.seleceTrainById(start_pass.get(s)); //中转之前的车1
                                        Train second_line = lineService.seleceTrainById(end_pass.get(e));//中转之后的车2
                                        String change_station = start_pass_line[ss];//中转站
                                        //车1到中转站的时间  中转站等车时间  中转站到车2下车时间
                                        String changeStationId = stationService.selectStationIdByName(change_station);//中转站id
                                        //车1
                                        Map startWayMap = new HashMap();
                                        startWayMap.put("stationId",startStationId);
                                        startWayMap.put("traId",first_line.getTraId());
                                        Station startStationTime = wayService.selectTimeByStationIdAndTrainId(startWayMap);
                                        Date outFirstTime = startStationTime.getWay().getOutTime();//出发站 出站时间
                                        //中转
                                        Map changeFirstWayMap = new HashMap();
                                        changeFirstWayMap.put("stationId",changeStationId);
                                        changeFirstWayMap.put("traId",first_line.getTraId());
                                        Station changeStationInTime = wayService.selectTimeByStationIdAndTrainId(changeFirstWayMap);
                                        Date inChangeTime1 = changeStationInTime.getWay().getInTime();//中转站 进站时间 车1

                                        long t1 = printDateLong(outFirstTime,inChangeTime1);

                                        Map changeSecondWayMap = new HashMap();
                                        changeSecondWayMap.put("stationId",changeStationId);
                                        changeSecondWayMap.put("traId",second_line.getTraId());
                                        Station changeStationOutTime = wayService.selectTimeByStationIdAndTrainId(changeSecondWayMap);
                                        Date outChangeTime = changeStationOutTime.getWay().getOutTime();//中转站 出站时间
                                        Date inChangeTime2 = changeStationOutTime.getWay().getInTime();//中转站 jin站时间

                                        long t3 = printDateLong(inChangeTime1,inChangeTime2);  //等待中转车 时间
                                        //车2
                                        Map endWayMap = new HashMap();
                                        endWayMap.put("stationId",endStationId);
                                        endWayMap.put("traId",second_line.getTraId());
                                        Station endStationTime = wayService.selectTimeByStationIdAndTrainId(endWayMap);
                                        Date inSecondTime = endStationTime.getWay().getInTime();//末站 进站时间

                                        long t2 = printDateLong(outChangeTime,inSecondTime);
                                        long t = addDate(t1,t2,t3);
                                        //printDate(t);

                                        Map map = new HashMap();
                                        map.put("type","中转");
                                        map.put("traName",first_line.getTraName());
                                        map.put("traName2",second_line.getTraName());
                                        map.put("change",change_station+"(停留"+printDate(t3) + ")");
                                        map.put("change2",change_station);
                                        map.put("outTime",outFirstTime);
                                        map.put("inTime",inSecondTime);
                                        map.put("time",printDate(t));
                                        map.put("startStation",startStation);
                                        map.put("endStation",endStation);
                                        list.add(map);
                                        //list.add(first_line.getTraName() + change_station + second_line.getTraName() + printDate(t)+




                                    }
                            }
                    }
                }
            }
            /*if (station_temp.length > 0) {
                for (int i = 0; i < station_temp.length; i++) {
                    if (station_temp[i] != null) {
                        System.out.println("中转乘车路线如下：\n" + station_temp[i]);
                        list.add(station_temp[i]);
                    }
                }
            }*/



        return list;

    }
}
