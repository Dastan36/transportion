package com.hrbu.controller;

import org.junit.Test;

import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AdminControllerTest {

    @Test
    public void test1(){
        String a = "123";
        Integer.parseInt(a);
        System.out.println(a);
        String.valueOf(a);
        System.out.println();

        Date data = new Date();
        System.out.println(data.getTime());

    }
    @Test
    public void test2(){
        String name = "x123s的管理考核得分123";
        //使用正则表达式
        Pattern pattern = Pattern.compile("[^\u4E00-\u9FA5]");
        //[\u4E00-\u9FA5]是unicode2的中文区间
        Matcher matcher = pattern.matcher(name);
        System.out.println(name.replaceAll("[^\\u4e00-\\u9fa5]", "").equals(""));
    }

}