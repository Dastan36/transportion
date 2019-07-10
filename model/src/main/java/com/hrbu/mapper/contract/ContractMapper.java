package com.hrbu.mapper.contract;

import com.hrbu.domain.Contract;

public interface ContractMapper {

    Contract selectContract() throws Exception;

    int updateContract(Contract contract) throws Exception;

}
