package com.hrbu.domain;

public class Contract {

    private  String contractId;
    private String contractEdit;

    public Contract() {
    }

    public Contract(String contractId, String contractEdit) {
        this.contractId = contractId;
        this.contractEdit = contractEdit;
    }

    public String getContractId() {
        return contractId;
    }

    public void setContractId(String contractId) {
        this.contractId = contractId;
    }

    public String getContractEdit() {
        return contractEdit;
    }

    public void setContractEdit(String contractEdit) {
        this.contractEdit = contractEdit;
    }
}
