package com.hrbu.service.user;

import com.hrbu.domain.User;
import com.hrbu.mapper.user.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public int selectCount(Map map) throws Exception{

        return userMapper.selectCount(map);
    }

    @Override
    public List<User> selectUser(Map map) throws Exception{
        int pageRow = ((int)map.get("pageNum")-1) * 9;// 页开始行 = 第几页-1 * 每页的条数

        map.put("pageRow",pageRow);
        List<User> list = userMapper.findUserList(map);

        return list;
    }

    @Override
    public boolean saveUser(User user) throws Exception{

        int count = userMapper.saveUser(user);
        return count>0;
    }

    @Override
    public void deleteUser(String userId) throws Exception{

        userMapper.deleteUser(userId);
    }

    /**
     * toupdate时直接查用户
     * @param userId
     * @return
     */
    @Override
    public User toUpdate( String userId) throws Exception{
        User user = userMapper.findUserById(userId);
        return user;
    }

    @Override
    public boolean update(User user) throws Exception{

       int count = userMapper.updateUser(user);
       return count>0;
    }

    @Override
    public User  userLogin(User user) throws Exception{
       user = userMapper.userLogin(user);
       return user;
    }

    /**
     * 前台用户信息界面
     * @param userId
     * @return
     */
    @Override
    public User findUserById(String userId) throws Exception{

        return userMapper.findUserById(userId);
    }

    @Override
    public boolean updatePassword(Map map) throws Exception{

        int count= userMapper.updatePassword(map);
        return count>0;
    }

    @Override
    public List<User> verifyPhone(String userId) throws Exception {

        return userMapper.verifyPhone(userId);
    }


}
