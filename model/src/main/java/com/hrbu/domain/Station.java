package com.hrbu.domain;

/**
 * 线路方案
 */
public class Station {

    private String stationId;
    private String stationName;
    private String coordinate_l;
    private String coordinate_r;
    private String city;
    private String province;
    private Way way;

    public Station() {
    }

    public Station(String stationId, String stationName, String coordinate_l, String coordinate_r, String city, String province, Way way) {
        this.stationId = stationId;
        this.stationName = stationName;
        this.coordinate_l = coordinate_l;
        this.coordinate_r = coordinate_r;
        this.city = city;
        this.province = province;
        this.way = way;
    }

    public String getStationId() {
        return stationId;
    }

    public void setStationId(String stationId) {
        this.stationId = stationId;
    }

    public String getStationName() {
        return stationName;
    }

    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    public String getCoordinate_l() {
        return coordinate_l;
    }

    public void setCoordinate_l(String coordinate_l) {
        this.coordinate_l = coordinate_l;
    }

    public String getCoordinate_r() {
        return coordinate_r;
    }

    public void setCoordinate_r(String coordinate_r) {
        this.coordinate_r = coordinate_r;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public Way getWay() {
        return way;
    }

    public void setWay(Way way) {
        this.way = way;
    }

    @Override
    public String toString() {
        return "Station{" +
                "stationId='" + stationId + '\'' +
                ", stationName='" + stationName + '\'' +
                ", coordinate_l='" + coordinate_l + '\'' +
                ", coordinate_r='" + coordinate_r + '\'' +
                ", city='" + city + '\'' +
                ", way=" + way +
                '}';
    }
}
