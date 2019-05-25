package com.hrbu.service.user;

import com.hrbu.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    public int selectCount(Map map) throws Exception;//查询总条数

    public List<User> selectUser(Map map) throws Exception;  //pageNum 第几页  分页 模糊查询分页

    public void saveUser(User user) throws Exception;

    public void deleteUser(String userId) throws Exception;

    public User toUpdate(String userId) throws Exception;

    public void update(User user) throws Exception;

    public User userLogin(User user) throws Exception;

    public User findUserById(String userId) throws Exception;

    void updatePassword(Map map) throws Exception;

    List<User> verifyPhone(String userId) throws Exception;
}
