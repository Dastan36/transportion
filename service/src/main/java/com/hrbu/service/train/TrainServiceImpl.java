package com.hrbu.service.train;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Train;
import com.hrbu.mapper.train.TrainMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class TrainServiceImpl implements TrainService{

    @Autowired
    private TrainMapper trainMapper;


    @Override
    public int selectCount(Map map) throws Exception{

        return trainMapper.selectCount(map);
    }

    @Override
    public List<Train> findTrainList(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        List traList = trainMapper.findTrainList(map);
        return traList;
    }

    //用于 快运班列 添加时关联所属机构 查询机构信息
    public List<Organize> selectOrg() throws Exception{
        List orgList = trainMapper.selectOrg();
        return orgList;
    }

    @Override
    public Organize selectOrgById(String orgId)  throws Exception{

        return trainMapper.selectOrgById(orgId);
    }

    @Override
    public Train selectTrainById(String traId) throws Exception{

        return trainMapper.selectTrainById(traId);
    }

    @Override
    public boolean saveTrain(Map map) throws Exception{
        map.put("traId",UUID.randomUUID().toString());
        map.put("createTime",new Date());
        int count = trainMapper.saveTrain(map);
        return count>0;
    }

    @Override
    public boolean deleteTrain(String traId) throws Exception{
        trainMapper.deleteTrainWay(traId);
        int count = trainMapper.deleteTrain(traId);
        return count>0;
    }

    @Override
    public boolean updateTrain(Map map) throws Exception{
        int count = trainMapper.updateTrain(map);
        return count>0;
    }
}
