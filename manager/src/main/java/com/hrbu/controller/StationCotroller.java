package com.hrbu.controller;

import com.hrbu.domain.Station;
import com.hrbu.service.station.StationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/station")
public class StationCotroller {

    @Autowired
    private StationService stationService;

    @RequestMapping("/stationlist")
    public String findStationList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "stationName",required=false) String stationName,String province) throws Exception {
        Map map = new HashMap();
        int pageNum = 1;    //分页 第几页 默认第一页
        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        map.put("pageNum",pageNum);
        map.put("stationName",stationName);
        int pageCount = stationService.selectCount(map);//总条数
        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        List stationList = stationService.findStationList(map);
        model.addAttribute("stationList",stationList);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageCount",pageCount);
        return "station/station_list";
    }

    @RequestMapping("/toadd")
    public String toAdd(){

        return "station/station_add";
    }

    @RequestMapping("/savestation")
    public String saveStation(@RequestParam String stationName,@RequestParam String coordinate_l,@RequestParam String coordinate_r,@RequestParam String city, @RequestParam String province) throws Exception {
        Map map = new HashMap();
        map.put("stationName",stationName);
        map.put("coordinate_l",coordinate_l);
        map.put("coordinate_r",coordinate_r);
        map.put("city",city);
        map.put("province",province);
        stationService.saveStation(map);
        return "redirect:/station/stationlist";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map deleteStation(@RequestParam String stationId) throws Exception {
        Map map = new HashMap();
        stationService.deleteStation(stationId);
        map.put("success",true);
        return map;
    }

    @RequestMapping("/toupdate")
    public String toUpdate(Model model,@RequestParam String stationId) throws Exception {
        Station station = stationService.selectStationById(stationId);
        model.addAttribute("station",station);
        return "station/station_update";
    }

    @RequestMapping("/update")
    public String update(@RequestParam String stationId,@RequestParam String stationName,@RequestParam String coordinate_l,@RequestParam String coordinate_r,@RequestParam String city,@RequestParam String province) throws Exception {
        Map map = new HashMap();
        map.put("stationId",stationId);
        map.put("stationName",stationName);
        map.put("coordinate_l",coordinate_l);
        map.put("coordinate_r",coordinate_r);
        map.put("city",city);
        map.put("province",province);
        stationService.updateStation(map);
        return "redirect:/station/stationlist";
    }


}
