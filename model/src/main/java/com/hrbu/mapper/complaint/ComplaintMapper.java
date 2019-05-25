package com.hrbu.mapper.complaint;

import com.hrbu.domain.Complaint;
import com.hrbu.domain.Order;

import java.util.List;
import java.util.Map;

public interface ComplaintMapper {
    int selectCount(Map map)throws Exception;

    List<Complaint> selectComplaint(Map map)throws Exception;

    void cancelComplaint(String complaintId)throws Exception;

    void insertComplaint(Map map)throws Exception;

    Order selectDetails(String complaintId)throws Exception;

    void updateComplaint(Map map)throws Exception;

    Order complaintVerifyOrderId(String orderId)throws Exception;
}
