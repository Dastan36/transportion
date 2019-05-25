package com.hrbu.domain;

import java.util.List;

/**
 * 批量操作时 中间集合类
 */
public class StationList {

    public List<Station> addList;
    public List<Way> wayList;

    public StationList() {
    }

    public StationList(List<Station> addList, List<Way> wayList) {
        this.addList = addList;
        this.wayList = wayList;
    }

    public List<Station> getAddList() {
        return addList;
    }

    public void setAddList(List<Station> addList) {
        this.addList = addList;
    }

    public List<Way> getWayList() {
        return wayList;
    }

    public void setWayList(List<Way> wayList) {
        this.wayList = wayList;
    }
}
