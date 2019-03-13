package com.huaruan.dao;

import com.huaruan.entity.Emp;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmpDao {
    //分页查询所有
    List<Emp> findByPage(@Param("start")Integer start,@Param("rows") Integer rows);
    //查询总条数
    Long findTotals();
    //删除一行
    void deleteRow(int id);
    //修改
    void updateRow(Emp emp);
    //查询单条
    Emp queryOne(int id);
    //添加
    void addOne(Emp emp);
    //模糊查询
    List<Emp> likeAll(String name);
    //批量删除
    void delMany(@Param("ids") int[] ids);
}
