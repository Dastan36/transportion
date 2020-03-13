package com.hrbu.service.complaint;

import com.hrbu.domain.Complaint;
import com.hrbu.domain.Order;
import com.hrbu.mapper.complaint.ComplaintMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ComplaintServiceImpl implements ComplaintService {

    @Autowired
    private ComplaintMapper complaintMapper;
    @Override
    public int selectCount(Map map) throws Exception{

        return complaintMapper.selectCount(map);
    }

    @Override
    public List<Complaint> selectComplaint(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数
        map.put("pageRow",pageRow);
        return complaintMapper.selectComplaint(map);
    }

    @Override
    public void cancelComplaint(String orderId) throws Exception {

        complaintMapper.cancelComplaint(orderId);
    }

    @Override
    public boolean insertComplaint(Map map) throws Exception{

        int count = complaintMapper.insertComplaint(map);
        return count>0;
    }

    @Override
    public Order selectDetails(String complaintId) throws Exception{

        return complaintMapper.selectDetails(complaintId);
    }

    @Override
    public boolean updateComplaint(Map map) throws Exception{

        int count = complaintMapper.updateComplaint(map);
        return count>0;
    }

    @Override
    public Order complaintVerifyOrderId(String orderId) throws Exception{

        return complaintMapper.complaintVerifyOrderId(orderId);
    }
}
