package com.huaruan.service;

import com.huaruan.dao.UserDao;
import com.huaruan.entity.User;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserServiceImpl {
    @Autowired
    private UserDao userDao;

    @Override
    public void insert(User user) {
        /*MD5加密*/
        String password = user.getPassword();
        String s = DigestUtils.md5Hex(password);
        user.setPassword(s);
        userDao.insert(user);
    }

    @Override
    public User login(User user) {
        User login = userDao.login(user);
        return login;
    }

    @Override
    public User selectUserame(String username) {
        User user = userDao.selectName(username);
        return user;
    }


}
