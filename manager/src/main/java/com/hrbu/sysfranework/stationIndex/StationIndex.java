package com.hrbu.sysfranework.stationIndex;

public class StationIndex {

    public static int printArray(String[] arr, String value){
        for(int i = 0;i<arr.length;i++){
            if(value.equals(arr[i])){
                return i;
            }
        }
        return -1;
    }
}
