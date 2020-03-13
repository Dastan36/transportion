package com.hrbu.service.contract;

import com.hrbu.domain.Contract;

public interface ContractService {

    Contract selectContract() throws Exception;

    boolean updateContract(Contract contract) throws Exception;
}
