package com.hrbu.domain;

import java.util.List;

/**
 * 批量操作时 中间集合类
 */
public class StationList {

    public List<Station> addList;


    public StationList() {
    }

    public StationList(List<Station> addList) {
        this.addList = addList;

    }

    public List<Station> getAddList() {
        return addList;
    }

    public void setAddList(List<Station> addList) {
        this.addList = addList;
    }


}
