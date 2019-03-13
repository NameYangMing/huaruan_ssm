package com.huaruan.service;

import com.huaruan.entity.User;

public interface UserServiceImpl {
    /*注册*/
    void insert(User user);

    /*登录*/
    User login(User user);

    User selectUserame(String username);
}
