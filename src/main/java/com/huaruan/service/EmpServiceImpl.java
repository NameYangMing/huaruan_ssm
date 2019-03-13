package com.huaruan.service;

import com.huaruan.entity.Emp;

import java.util.List;

public interface EmpServiceImpl {
    //分页查询
    List<Emp> findByPage(Integer page,Integer rows);
    //查询所有
    Long findTotals();
    //删除一行
    void deleteRow(int id);
    //修改
    void updateRow(Emp emp);
    //查询单条
    Emp findOne(int id);
    //添加
    void saveOne(Emp emp);
    //模糊插叙
    List<Emp> searchAll(String name);
    //批量删除
    void removeMany(int[] ids);

}
