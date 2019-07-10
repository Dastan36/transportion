package com.hrbu.domain;

import java.util.List;

public class Province {

    private String proId;
    private String province;
    private List<OrganizeProvince> organizeProvince;

    public Province() {
    }

    public Province(String proId, String province, List<OrganizeProvince> organizeProvince) {
        this.proId = proId;
        this.province = province;
        this.organizeProvince = organizeProvince;
    }

    public String getProId() {
        return proId;
    }

    public void setProId(String proId) {
        this.proId = proId;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public List<OrganizeProvince> getOrganizeProvince() {
        return organizeProvince;
    }

    public void setOrganizeProvince(List<OrganizeProvince> organizeProvince) {
        this.organizeProvince = organizeProvince;
    }
}
