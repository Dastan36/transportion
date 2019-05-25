package com.hrbu.domain;

import java.util.Date;

public class Complaint {

    private String complaintId;
    private String complaintType;
    private String complaintName;
    private String complaintPhone;
    private String complaintDescribe;
    private String status;
    private Date createTime;

    public Complaint() {
    }

    public Complaint(String complaintId, String complaintType, String complaintName, String complaintPhone, String complaintDescribe, String status, Date createTime) {
        this.complaintId = complaintId;
        this.complaintType = complaintType;
        this.complaintName = complaintName;
        this.complaintPhone = complaintPhone;
        this.complaintDescribe = complaintDescribe;
        this.status = status;
        this.createTime = createTime;
    }

    public String getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(String complaintId) {
        this.complaintId = complaintId;
    }

    public String getComplaintType() {
        return complaintType;
    }

    public void setComplaintType(String complaintType) {
        this.complaintType = complaintType;
    }

    public String getComplaintName() {
        return complaintName;
    }

    public void setComplaintName(String complaintName) {
        this.complaintName = complaintName;
    }

    public String getComplaintPhone() {
        return complaintPhone;
    }

    public void setComplaintPhone(String complaintPhone) {
        this.complaintPhone = complaintPhone;
    }

    public String getComplaintDescribe() {
        return complaintDescribe;
    }

    public void setComplaintDescribe(String complaintDescribe) {
        this.complaintDescribe = complaintDescribe;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}
