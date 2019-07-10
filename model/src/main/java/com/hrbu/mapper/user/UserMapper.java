package com.hrbu.mapper.user;

import com.hrbu.domain.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {

    //总条数
    public int selectCount(Map map) throws Exception;

    public List<User> findUserList(Map map) throws Exception;

    public User findUserById(String userId) throws Exception;

    public int saveUser(User user) throws Exception;

    public void deleteUser(String userId) throws Exception;

    public int updateUser(User user) throws Exception;

    public User userLogin(User user) throws Exception;

    int updatePassword(Map map) throws Exception;

    public List<User> verifyPhone(String userId) throws Exception;



}
