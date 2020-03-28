package com.hrbu.mapper.console;

import java.util.List;
import java.util.Map;

public interface ConsoleMapper {
    int selectNewOrderNum() throws Exception;
    int selectNewRegisterNum() throws Exception;
    int selectNewArriveNum() throws Exception;
    List<Map> selectComplaintCount() throws Exception;
}
