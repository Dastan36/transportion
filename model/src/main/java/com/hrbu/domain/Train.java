package com.hrbu.domain;


import java.util.Date;
import java.util.List;

public class Train {

    private String traId;
    private String traName;
    private Date createTime;
    private List<Way> way;
    private String createWay;//是否创建线路
    private List<TrainsOrder> trainsOrders;

    public Train() {
    }

    public Train(String traId, String traName, Date createTime, List<Way> way, String createWay) {
        this.traId = traId;
        this.traName = traName;
        this.createTime = createTime;
        this.way = way;
        this.createWay = createWay;
    }

    public Train(List<TrainsOrder> trainsOrders) {
        this.trainsOrders = trainsOrders;
    }

    public String getTraId() {
        return traId;
    }

    public void setTraId(String traId) {
        this.traId = traId;
    }

    public String getTraName() {
        return traName;
    }

    public void setTraName(String traName) {
        this.traName = traName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<Way> getWay() {
        return way;
    }

    public void setWay(List<Way> way) {
        this.way = way;
    }

    public String getCreateWay() {
        return createWay;
    }

    public void setCreateWay(String createWay) {
        this.createWay = createWay;
    }

    public List<TrainsOrder> getTrainsOrders() {
        return trainsOrders;
    }

    public void setTrainsOrders(List<TrainsOrder> trainsOrders) {
        this.trainsOrders = trainsOrders;
    }

    @Override
    public String toString() {
        return "Train{" +
                "traId='" + traId + '\'' +
                ", traName='" + traName + '\'' +
                ", createTime=" + createTime +
                ", way=" + way +
                ", createWay='" + createWay + '\'' +
                '}';
    }
}
