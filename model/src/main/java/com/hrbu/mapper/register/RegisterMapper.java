package com.hrbu.mapper.register;

import com.hrbu.domain.User;

import java.util.List;

public interface RegisterMapper {

    int register (User user) throws Exception;

    List<User> verifyPhone(String telephone) throws Exception;
}
