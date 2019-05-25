package com.hrbu.service.train;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Train;

import java.util.List;
import java.util.Map;

public interface TrainService {

    int selectCount(Map map) throws Exception;

    List<Train> findTrainList(Map map) throws Exception;

    //用于 快运班列 添加时关联所属机构 查询机构信息
    List<Organize> selectOrg() throws Exception;

    //用于 快运班列 修改时关联所属机构 查询出机构信息
    Organize selectOrgById(String orgId) throws Exception;

    Train selectTrainById(String traId) throws Exception;

    void saveTrain(Map map) throws Exception;

    void deleteTrain(String traId) throws Exception;

    void updateTrain(Map map) throws Exception;


}
