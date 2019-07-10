package com.hrbu.service.contract;


import com.hrbu.domain.Contract;
import com.hrbu.mapper.contract.ContractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractServiceImpl implements ContractService{

    @Autowired
    private  ContractMapper contractMapper;

    @Override
    public Contract selectContract() throws Exception {
        return contractMapper.selectContract();
    }

    @Override
    public boolean updateContract(Contract contract) throws Exception {
        int count = contractMapper.updateContract(contract);
        return count>0;
    }
}
