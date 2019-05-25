package com.hrbu.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Admin {
    private String adminId;
    private String adminName;
    private String password;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createTime;


    public Admin() {
    }

    public Admin(String adminId, String adminName, String password, Date createTime) {
        this.adminId = adminId;
        this.adminName = adminName;
        this.password = password;
        this.createTime = createTime;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
