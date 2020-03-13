package com.hrbu.sysfranework.stationIndex;

import java.util.Date;

public class LineMatchUtil {

    public static int printArray(String[] arr, String value){
        for(int i = 0;i<arr.length;i++){
            if(value.equals(arr[i])){
                return i;
            }
        }
        return -1;
    }

    public static long printDateLong(Date outTime, Date inTime){
        long l;
        System.out.println(outTime.getTime());
        System.out.println(inTime.getTime());
        if (outTime.getTime() >= inTime.getTime()){
            l = outTime.getTime() - inTime.getTime() + 24 * 60 * 60 * 1000;

        }else{
            l = inTime.getTime() - outTime.getTime() ;
        }

        return l;
    }

    public static long addDate(long l1,long l2,long l3){
        long l = l1 + l2 + l3;
        return l;
    }

    public static String printDate(long l){
        String d;
        String h;
        String m;
        String s;

        long day = l / (24 * 60 * 60 * 1000);
        long hour = (l / (60 * 60 * 1000) - day * 24);
        long min = ((l / (60 * 1000)) - day * 24 * 60 - hour * 60);
        long sec = (l / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60);
        if (day == 0){
            d = "";
        }else {
            d = day+"天";
        }
        if (hour == 0){
            h = "";
        }else {
            h = hour+"时";
        }
        if (min == 0){
            m = "";
        }else {
            m = min+"分";
        }
        if (sec == 0){
            s = "";
        }else {
            s = sec+"秒";
        }

        return d+h+m+s;
    }

}
