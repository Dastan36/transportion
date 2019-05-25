package com.hrbu.sysfranework.dateConvert;

import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *  1 自定义 格式转换器
 *
 */
public class DateConvert implements Converter<String , Date> {


    //private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    private static List<SimpleDateFormat> sdfs = new ArrayList();
    static{

        sdfs.add(new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss")  );
        sdfs.add(new  SimpleDateFormat("yyyy-MM-dd HH:mm")  );
        sdfs.add(new  SimpleDateFormat("yyyy-MM-dd HH")  );
        sdfs.add(new  SimpleDateFormat("yyyy-MM-dd")  );
        sdfs.add(new  SimpleDateFormat("HH:mm:ss")  );
        sdfs.add(new  SimpleDateFormat("yyyy/MM/dd HH:mm:ss")  );
        sdfs.add(new  SimpleDateFormat("yyyy/MM/dd HH:mm")  );
        sdfs.add(new  SimpleDateFormat("yyyy/MM/dd HH")  );
        sdfs.add(new  SimpleDateFormat("yyyy/MM/dd")  );


    }

    @Override
    public Date convert(String s) {


        Date date = null;

        for (SimpleDateFormat sdf : sdfs) {

            try {
                date = sdf.parse(s);
                break;
            } catch (ParseException e) {
                e.printStackTrace();
            }

        }

        return date;
    }
}
