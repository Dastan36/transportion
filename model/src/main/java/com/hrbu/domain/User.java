package com.hrbu.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class User {

    private String userId;
    private String userName;
    private String password;
    private String telephone;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private String status;



    public User() {
    }

    public User(String userId, String userName, String password, String telephone, Date createTime, String status) {
        this.userId = userId;
        this.userName = userName;
        this.password = password;
        this.telephone = telephone;
        this.createTime = createTime;
        this.status = status;

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
