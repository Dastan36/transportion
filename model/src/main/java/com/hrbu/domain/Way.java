package com.hrbu.domain;

import java.util.Date;

public class Way {

    private String wayId;
    private Date time;
    private int i;
    private Date inTime;
    private Date outTime;


    public Way() {
    }

    public Way(String wayId, Date time, int i, Date inTime, Date outTime) {
        this.wayId = wayId;
        this.time = time;
        this.i = i;
        this.inTime = inTime;
        this.outTime = outTime;
    }

    public String getWayId() {
        return wayId;
    }

    public void setWayId(String wayId) {
        this.wayId = wayId;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getI() {
        return i;
    }

    public void setI(int i) {
        this.i = i;
    }

    public Date getInTime() {
        return inTime;
    }

    public void setInTime(Date inTime) {
        this.inTime = inTime;
    }

    public Date getOutTime() {
        return outTime;
    }

    public void setOutTime(Date outTime) {
        this.outTime = outTime;
    }
}
