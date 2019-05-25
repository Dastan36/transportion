package com.hrbu.service.register;

import com.hrbu.domain.User;
import com.hrbu.mapper.register.RegisterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegisterServiceImpl implements RegisterService {

    @Autowired
    private RegisterMapper registerMapper;
    @Override
    public boolean register(User user) throws Exception{
         int count = registerMapper.register(user);
         return count>0;
    }

    @Override
    public List<User> verifyPhone(String telephone) throws Exception{

        return registerMapper.verifyPhone(telephone);
    }
}
