package com.hrbu.domain;

public class OrganizeProvince {
    private int id;
    private String province;

    public OrganizeProvince() {
    }

    public OrganizeProvince(int id, String province) {
        this.id = id;
        this.province = province;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }
}
