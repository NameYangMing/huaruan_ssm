package com.huaruan.dao;

import com.huaruan.entity.User;

public interface UserDao {
    /*注册*/
    void insert(User user);

    /*登录*/
    User login(User user);

    /*账号查询*/
    User selectName(String username);

}
