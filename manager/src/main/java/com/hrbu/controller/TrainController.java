package com.hrbu.controller;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Train;
import com.hrbu.service.train.TrainService;
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
@RequestMapping("/train")
public class TrainController {

    @Autowired
    private TrainService trainService;

    @RequestMapping("/tolist")
    public String toList(){

        return "train/train_list";
    }

    @ResponseBody
    @RequestMapping("/trainlist")
    public Map findTrainList(Model model,@RequestParam(value = "pageNum",required=false) String pageNumStr,@RequestParam(value = "traName",required=false) String traName,@RequestParam(value = "orgName",required=false) String orgName) throws Exception {
        Map map = new HashMap();
        int pageNum = 1;    //分页 第几页 默认第一页
        if(pageNumStr !=null && !"".equals(pageNumStr)) {
            pageNum = Integer.parseInt(pageNumStr);
        }
        map.put("pageNum",pageNum);
        map.put("traName",traName);
        map.put("orgName",orgName);
        int pageCount = trainService.selectCount(map);//总条数
        //pageCount = (pageCount%9==0)?(pageCount/9):((pageCount/9)+1);//页数  每页显示9条
        List organizeList = trainService.findTrainList(map);
//        model.addAttribute("organizeList",organizeList);
//        model.addAttribute("pageNum",pageNum);
//        model.addAttribute("pageCount",pageCount);
        map.put("organizeList",organizeList);
        map.put("pageCount",pageCount);
        return map;
    }

    @RequestMapping("/toadd")
    public String toAdd(Model model) throws Exception {
        List orgList = trainService.selectOrg();//添加时查询所属机构  关联
        model.addAttribute("orgList",orgList);
        return "train/train_add";
    }

    @ResponseBody
    @RequestMapping("/savetrain")
    public boolean saveTrain(@RequestParam String traName,@RequestParam String orgId) throws Exception {
        Map map = new HashMap();
        map.put("traName",traName);
        map.put("orgId",orgId);
        boolean flag = false;
        flag = trainService.saveTrain(map);
        return flag;
    }

    @RequestMapping("/delete")
    @ResponseBody                                //ajax json传参删除
    public Map delete(@RequestParam("traId") String traId) throws Exception {
        Map map = new HashMap();
        //System.out.println(traId);
        boolean flag = false;
        flag = trainService.deleteTrain(traId);
        if (flag){
            map.put("success",true);
        }else{
            map.put("success",false);
        }
        return map;
    }

    @RequestMapping("/toupdate")
    public String toUpdate(Model model, @RequestParam("traId")String traId,@RequestParam("orgId")String orgId) throws Exception {
        Train train = trainService.selectTrainById(traId);
        Organize organize = trainService.selectOrgById(orgId);  //单独查询orgId 获取所属机构名
        List orgList = trainService.selectOrg();                //获取org列表
        model.addAttribute("train",train);
        model.addAttribute("organize",organize);
        model.addAttribute("orgList",orgList);
        return "train/train_update";
    }

    @ResponseBody
    @RequestMapping("/update")
    public boolean update(@RequestParam String traId,@RequestParam String traName,@RequestParam String orgId) throws Exception {
        Map map = new HashMap();
        map.put("traId",traId);
        map.put("traName",traName);
        map.put("orgId",orgId);
        boolean flag;
        flag = trainService.updateTrain(map);
        return flag;
    }




}
