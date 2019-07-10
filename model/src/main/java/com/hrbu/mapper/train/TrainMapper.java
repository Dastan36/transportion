package com.hrbu.mapper.train;

import com.hrbu.domain.Organize;
import com.hrbu.domain.Train;

import java.util.List;
import java.util.Map;

public interface TrainMapper {

    int selectCount(Map map) throws Exception;

    List<Organize> findTrainList(Map map) throws Exception;

    //用于 快运班列 下拉选 添加时关联所属机构 查询出机构信息
    List<Organize> selectOrg() throws Exception;

    //用于 快运班列 下拉选 修改时关联所属机构 查询出机构信息
    Organize selectOrgById(String orgId) throws Exception;

    Train selectTrainById(String traId) throws Exception;

    int saveTrain(Map map) throws Exception;

    int deleteTrain(String traId) throws Exception;
    void deleteTrainWay(String traId) throws Exception;

    int updateTrain(Map map) throws Exception;
}
