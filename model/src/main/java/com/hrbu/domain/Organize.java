package com.hrbu.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 组织机构 铁路局
 */
public class Organize {

    private String orgId;
    private String orgName;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private List<Train> train;
    private List<Province> province;

    public Organize() {
    }

    public Organize(String orgId, String orgName, Date createTime, List<Train> train, List<Province> province) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.createTime = createTime;
        this.train = train;
        this.province = province;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public List<Train> getTrain() {
        return train;
    }

    public void setTrain(List<Train> train) {
        this.train = train;
    }

    public List<Province> getProvince() {
        return province;
    }

    public void setProvince(List<Province> province) {
        this.province = province;
    }
}
