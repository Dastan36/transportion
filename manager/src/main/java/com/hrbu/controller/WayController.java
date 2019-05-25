package com.hrbu.controller;

import com.hrbu.domain.Station;
import com.hrbu.domain.StationList;
import com.hrbu.service.way.WayService;
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
@RequestMapping("/way")
public class WayController {

    @Autowired
    private WayService wayService;

    @RequestMapping("/waylist")
    public String findTrainList(Model model, @RequestParam(value = "pageNum",required=false) String pageNumStr, @RequestParam(value = "traName",required=false) String traName) throws Exception {
        Map map = new HashMap();
        int pageNum = 1;    //分页 第几页 默认第一页
        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        map.put("pageNum",pageNum);
        map.put("traName",traName);

        int pageCount = wayService.selectCount(map);//总条数
        pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        List wayList = wayService.findWayList(map);
        model.addAttribute("wayList",wayList);
        model.addAttribute("pageNum",pageNum);
        model.addAttribute("pageCount",pageCount);
        return "way/way_list";
    }

    @RequestMapping("/tocreate")
    public String toCreate(Model model) throws Exception {
        List trainList = wayService.selectTrain();
        List stationList = wayService.selectStation();
        model.addAttribute("trainList",trainList);
        model.addAttribute("stationList",stationList);
        return "way/way_create";
    }

    @RequestMapping("/create")
    public String create(String traId, StationList stationList) throws Exception {
        //System.out.println(traId);
        //System.out.println(stationList.getAddList());
        Map map = new HashMap();
        map.put("traId",traId);
        map.put("wayList",stationList.getAddList());
        wayService.insertWay(map);
        map.put("createWay","1");  //标志位 创建过线路的列出不再显示在创建列表
        wayService.updateCreateWay(map);//创建线路之后 将Train 是否创建线路的标志位 值1  默认0
        return "redirect:/way/waylist";
    }

    @RequestMapping("/waydetail")
    public String waydetail(Model model,String traId,String traName) throws Exception {
        Map map = new HashMap();
        map.put("traId",traId);
        List wayStationList = wayService.selectStationById(map);
        model.addAttribute("stationList",wayStationList);
        model.addAttribute("traName",traName);
        model.addAttribute("traId",traId);
        return "way/way_detail";
    }

    /**
     *地图上显示路线      通过线路查到车站id --》 stationList
     * @param traId
     * @return
     */
    @RequestMapping("/waydir")
    @ResponseBody
    public Map wayDir(@RequestParam String traId) throws Exception {
        Map map = new HashMap();
        map.put("traId",traId);
        List<Station> stationList = wayService.selectStationById(map);

       // System.out.println("asd");
        map.put("stationList",stationList);
        return map;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map delete(@RequestParam String traId) throws Exception {
        Map map = new HashMap();
        wayService.deleteWay(traId);
        map.put("createWay","0");
        map.put("traId",traId);
        wayService.updateCreateWayDel(map);
        map.put("success",true);
        return map;
    }

}
