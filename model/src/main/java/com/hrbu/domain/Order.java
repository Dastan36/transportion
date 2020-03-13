package com.hrbu.domain;

import java.util.Date;
import java.util.List;

public class Order {

    private String orderId;
    private String senderName;
    private String senderPhone;
    private String senderProvince;
    private String senderStation;
    private String receiptName;
    private String receiptPhone;
    private String receiptProvince;
    private String receiptStation;
    private String goodsName;
    private Double goodsWeight;
    private Double goodsVolume;
    private Date createTime;
    private Date transTime;
    private String currentCoordinate_l;
    private String currentCoordinate_r;
    private String money;
    private String moneyStatus;//付款方式 状态
    private String lineMatch; //线路p匹配
    private String status;
    private String getStatus;
    //private int isDelete;//默认为1 客户删除后为0 控制显示 管理员还是可以看见
    private Date arriveTime;
    private Date getTime;
    private List<Complaint> complaint;
    private List<Compensate> compensate;
    private TrainsOrder trainsOrder;

    public Order() {
    }

    public Order(String orderId, String senderName, String senderPhone, String senderProvince, String senderStation, String receiptName, String receiptPhone, String receiptProvince, String receiptStation, String goodsName, Double goodsWeight, Double goodsVolume, Date createTime, Date transTime, String currentCoordinate_l, String currentCoordinate_r, String money, String moneyStatus, String lineMatch, String status, String getStatus,  Date arriveTime, Date getTime, List<Complaint> complaint, List<Compensate> compensate) {
        this.orderId = orderId;
        this.senderName = senderName;
        this.senderPhone = senderPhone;
        this.senderProvince = senderProvince;
        this.senderStation = senderStation;
        this.receiptName = receiptName;
        this.receiptPhone = receiptPhone;
        this.receiptProvince = receiptProvince;
        this.receiptStation = receiptStation;
        this.goodsName = goodsName;
        this.goodsWeight = goodsWeight;
        this.goodsVolume = goodsVolume;
        this.createTime = createTime;
        this.transTime = transTime;
        this.currentCoordinate_l = currentCoordinate_l;
        this.currentCoordinate_r = currentCoordinate_r;
        this.money = money;
        this.moneyStatus = moneyStatus;
        this.lineMatch = lineMatch;
        this.status = status;
        this.getStatus = getStatus;
        this.arriveTime = arriveTime;
        this.getTime = getTime;
        this.complaint = complaint;
        this.compensate = compensate;
    }

    public Order(TrainsOrder trainsOrder) {
        this.trainsOrder = trainsOrder;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    public String getSenderStation() {
        return senderStation;
    }

    public void setSenderStation(String senderStation) {
        this.senderStation = senderStation;
    }

    public String getReceiptName() {
        return receiptName;
    }

    public void setReceiptName(String receiptName) {
        this.receiptName = receiptName;
    }

    public String getReceiptPhone() {
        return receiptPhone;
    }

    public void setReceiptPhone(String receiptPhone) {
        this.receiptPhone = receiptPhone;
    }

    public String getReceiptStation() {
        return receiptStation;
    }

    public void setReceiptStation(String receiptStation) {
        this.receiptStation = receiptStation;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Double getGoodsWeight() {
        return goodsWeight;
    }

    public void setGoodsWeight(Double goodsWeight) {
        this.goodsWeight = goodsWeight;
    }

    public Double getGoodsVolume() {
        return goodsVolume;
    }

    public void setGoodsVolume(Double goodsVolume) {
        this.goodsVolume = goodsVolume;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getTransTime() {
        return transTime;
    }

    public void setTransTime(Date transTime) {
        this.transTime = transTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGetStatus() {
        return getStatus;
    }

    public void setGetStatus(String getStatus) {
        this.getStatus = getStatus;
    }

    public String getLineMatch() {
        return lineMatch;
    }

    public void setLineMatch(String lineMatch) {
        this.lineMatch = lineMatch;
    }

    public String getCurrentCoordinate_l() {
        return currentCoordinate_l;
    }

    public void setCurrentCoordinate_l(String currentCoordinate_l) {
        this.currentCoordinate_l = currentCoordinate_l;
    }

    public String getCurrentCoordinate_r() {
        return currentCoordinate_r;
    }

    public void setCurrentCoordinate_r(String currentCoordinate_r) {
        this.currentCoordinate_r = currentCoordinate_r;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getMoneyStatus() {
        return moneyStatus;
    }

    public void setMoneyStatus(String moneyStatus) {
        this.moneyStatus = moneyStatus;
    }

    public Date getArriveTime() {
        return arriveTime;
    }

    public void setArriveTime(Date arriveTime) {
        this.arriveTime = arriveTime;
    }

    public Date getGetTime() {
        return getTime;
    }

    public void setGetTime(Date getTime) {
        this.getTime = getTime;
    }

    public List<Complaint> getComplaint() {
        return complaint;
    }

    public void setComplaint(List<Complaint> complaint) {
        this.complaint = complaint;
    }

    public List<Compensate> getCompensate() {
        return compensate;
    }

    public void setCompensate(List<Compensate> compensate) {
        this.compensate = compensate;
    }

    public String getSenderProvince() {
        return senderProvince;
    }

    public void setSenderProvince(String senderProvince) {
        this.senderProvince = senderProvince;
    }

    public String getReceiptProvince() {
        return receiptProvince;
    }

    public void setReceiptProvince(String receiptProvince) {
        this.receiptProvince = receiptProvince;
    }

    public TrainsOrder getTrainsOrders() {
        return trainsOrder;
    }

    public void setTrainsOrders(TrainsOrder trainsOrder) {
        this.trainsOrder = trainsOrder;
    }
}
