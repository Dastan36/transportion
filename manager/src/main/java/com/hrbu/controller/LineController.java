package com.hrbu.controller;


import com.hrbu.domain.Order;
import com.hrbu.domain.Station;
import com.hrbu.domain.Train;
import com.hrbu.service.line.LineService;
import com.hrbu.service.order.OrderService;
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
    @Autowired
    private OrderService orderService;

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

        Double weight = 60.0;//货物重量
        Double volume = 120.0;//货物体积

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
                    line_temp[i] = traId[i];  //直达车的id
                    //count++;
                    directFlag = 0;
                }
            }
        }
        //准备直达车数据
        for (int j = 0; j < line_temp.length; j++)
            if (line_temp[j] != null) {
                Train train = lineService.seleceTrainById(line_temp[j]);   //直达车
//                System.out.println(train.getTraName());
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

                //运力
                List<Order> orderList = trainOrderService.selectOrderIdByTraId(train.getTraId());//这辆列车上所有订单id 只有ID
                for (int i = 0; i < orderList.size(); i++) {
                    Order order = orderService.selectById(orderList.get(i).getOrderId());  //根据id找到订单信息
                    String _receiptStation = order.getReceiptStation();
                    String[] line = lineService.selectStationById(train.getTraId());//该辆车的路线  路线上的站点数组
                    // 不存在线路站点上找不到上下车位置？
                    int _index = printArray(line, _receiptStation);  //订单的下车位置
//                    int __index = printArray(line, order.getSenderStation()); //该次订单的上车位置
                    int __index = printArray(line, startStation); //该次订单的上车位置
                    if(__index <= _index) {
                        weight = weight - Double.parseDouble(goodsWeight);
                        volume = volume - Double.parseDouble(goodsVolume);
                    }
                }
                Map map = new HashMap();
                map.put("type","直达");
                map.put("traId",train.getTraId());
                map.put("traName",train.getTraName());
                map.put("outTime",outTime);
                map.put("inTime",inTime);
                map.put("time",printDate(l));
                map.put("startStation",startStation);
                map.put("endStation",endStation);
                map.put("weight",weight);
                map.put("volume",volume);
                list.add(map);
            }

            /**
             * 没有直达  转车
             */
        int sss = 0;
        //经过始末点的所有列车id
        ArrayList<String> start_pass = lineService.selectTrainByStation(startStation);
        ArrayList<String> end_pass = lineService.selectTrainByStation(endStation);
        Double weight1 = 60.0, weight2 = 60.0;
        Double volume1 = 120.0, volume2 = 120.0;
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
                                    //车1运力
                                    List<Order> orderList1 = trainOrderService.selectOrderIdByTraId(first_line.getTraId());//这辆列车上所有订单id 只有ID
                                    for (int i = 0; i < orderList1.size(); i++) {
                                        Order order = orderService.selectById(orderList1.get(i).getOrderId());  //根据id找到订单信息
                                        String _receiptStation = order.getReceiptStation();
                                        String[] line = lineService.selectStationById(first_line.getTraId());//该辆车的路线  路线上的站点数组
                                        // 不存在线路站点上找不到上下车位置？
                                        int _index = printArray(line, _receiptStation);  //订单的下车位置
                                        int __index = printArray(line, startStation); //该次订单的上车位置
                                        if(__index <= _index) {
                                            weight1 = weight - Double.parseDouble(goodsWeight);
                                            volume1 = volume - Double.parseDouble(goodsVolume);
                                        }
                                    }

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
                                    //车2运力
                                    List<Order> orderList2 = trainOrderService.selectOrderIdByTraId(second_line.getTraId());//这辆列车上所有订单id 只有ID
                                    for (int i = 0; i < orderList2.size(); i++) {
                                        Order order = orderService.selectById(orderList2.get(i).getOrderId());  //根据id找到订单信息
                                        String _receiptStation = order.getReceiptStation();
                                        String[] line = lineService.selectStationById(second_line.getTraId());//该辆车的路线  路线上的站点数组
                                        // 不存在线路站点上找不到上下车位置？
                                        int _index = printArray(line, _receiptStation);  //订单的下车位置
                                        int __index = printArray(line, change_station); //该次订单的上车位置
                                        if(__index <= _index) {
                                            weight2 = weight - Double.parseDouble(goodsWeight);
                                            volume2 = volume - Double.parseDouble(goodsVolume);
                                        }
                                    }

                                    long t2 = printDateLong(outChangeTime,inSecondTime);
                                    long t = addDate(t1,t2,t3);
                                    //printDate(t);

                                    Map map = new HashMap();
                                    map.put("type","中转");
                                    map.put("traId", first_line.getTraId());
                                    map.put("traName",first_line.getTraName());
                                    map.put("traId2", second_line.getTraId());
                                    map.put("traName2",second_line.getTraName());
                                    map.put("change",change_station+"(停留"+printDate(t3) + ")");
                                    map.put("change2",change_station);
                                    map.put("outTime",outFirstTime);
                                    map.put("inTime",inSecondTime);
                                    map.put("time",printDate(t));
                                    map.put("startStation",startStation);
                                    map.put("endStation",endStation);
                                    map.put("weight1",weight1);map.put("weight2",weight2);
                                    map.put("volume1",volume1);map.put("volume2",volume2);

                                    list.add(map);
                                }
                        }
                }
            }
        }
        return list;
    }
}
