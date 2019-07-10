package com.hrbu.service.complaint;

import com.hrbu.domain.Complaint;
import com.hrbu.domain.Order;

import java.util.List;
import java.util.Map;

public interface ComplaintService {

    int selectCount(Map map) throws Exception;

    List<Complaint> selectComplaint(Map map) throws Exception;

    void cancelComplaint(String orderId) throws Exception;

    boolean insertComplaint(Map map) throws Exception;

    Order selectDetails(String complaintId) throws Exception;

    boolean updateComplaint(Map map) throws Exception;

    Order complaintVerifyOrderId(String orderId) throws Exception;

}
