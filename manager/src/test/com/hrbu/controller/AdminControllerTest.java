package com.hrbu.controller;

import org.junit.Test;

import java.util.Date;

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

}