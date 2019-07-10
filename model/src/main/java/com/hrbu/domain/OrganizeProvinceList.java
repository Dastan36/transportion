package com.hrbu.domain;

import java.util.List;

public class OrganizeProvinceList {

    String[] addproId;
    List<Province> addProvince;

    public OrganizeProvinceList() {
    }

    public OrganizeProvinceList(String[] addproId, List<Province> addProvince) {
        this.addproId = addproId;
        this.addProvince = addProvince;
    }

    public String[] getAddproId() {
        return addproId;
    }

    public void setAddproId(String[] addproId) {
        this.addproId = addproId;
    }

    public List<Province> getAddProvince() {
        return addProvince;
    }

    public void setAddProvince(List<Province> addProvince) {
        this.addProvince = addProvince;
    }
}
