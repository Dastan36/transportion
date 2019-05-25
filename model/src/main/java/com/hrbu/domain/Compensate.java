package com.hrbu.domain;

import java.util.Date;

public class Compensate {

    private String compensateId;
    private String userId;
    private String compensateName;
    private String compensateMoney;
    private Date compensateTime;
    private String compensateStatus;

    public Compensate() {
    }

    public Compensate(String compensateId, String userId, String compensateName, String compensateMoney, Date compensateTime, String compensateStatus) {
        this.compensateId = compensateId;
        this.userId = userId;
        this.compensateName = compensateName;
        this.compensateMoney = compensateMoney;
        this.compensateTime = compensateTime;
        this.compensateStatus = compensateStatus;
    }

    public String getCompensateId() {
        return compensateId;
    }

    public void setCompensateId(String compensateId) {
        this.compensateId = compensateId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCompensateName() {
        return compensateName;
    }

    public void setCompensateName(String compensateName) {
        this.compensateName = compensateName;
    }

    public String getCompensateMoney() {
        return compensateMoney;
    }

    public void setCompensateMoney(String compensateMoney) {
        this.compensateMoney = compensateMoney;
    }

    public Date getCompensateTime() {
        return compensateTime;
    }

    public void setCompensateTime(Date compensateTime) {
        this.compensateTime = compensateTime;
    }

    public String getCompensateStatus() {
        return compensateStatus;
    }

    public void setCompensateStatus(String compensateStatus) {
        this.compensateStatus = compensateStatus;
    }
}
