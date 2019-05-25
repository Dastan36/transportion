package com.hrbu.service.register;

import com.hrbu.domain.User;

import java.util.List;

public interface RegisterService {

    boolean register (User user) throws Exception;

    List<User> verifyPhone(String telephone) throws Exception;

}
