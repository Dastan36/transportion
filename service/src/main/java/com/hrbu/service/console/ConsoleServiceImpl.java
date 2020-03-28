package com.hrbu.service.console;

import com.hrbu.mapper.console.ConsoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ConsoleServiceImpl implements ConsoleService {

    @Autowired
    private ConsoleMapper consoleMapper;

    @Override
    public Map getNewNum() throws Exception {
        int newOrderNum = consoleMapper.selectNewOrderNum();
        int newRegisterNum = consoleMapper.selectNewRegisterNum();
        int newArriveNum = consoleMapper.selectNewArriveNum();
        Map map = new HashMap();
        map.put("newOrderNum", newOrderNum);
        map.put("newRegisterNum", newRegisterNum);
        map.put("newArriveNum", newArriveNum);
        return map;
    }

    @Override
    public Map getCompalainCount() throws Exception {
        List<Map> complaintInfo =  consoleMapper.selectComplaintCount();
        Map complaintCount = new HashMap();
        for(int i = 0; i < complaintInfo.size(); i++) {
            complaintCount.put(complaintInfo.get(i).get("complaintType"), complaintInfo.get(i).get("complaintCount"));
        }
        return complaintCount;
    }
}
