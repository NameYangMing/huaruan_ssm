package com.huaruan.service;

import com.huaruan.dao.EmpDao;
import com.huaruan.entity.Emp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpService implements EmpServiceImpl{
    @Autowired
    private EmpDao empDao;

    @Override
    public List<Emp> findByPage(Integer page, Integer rows) {
        int start=(page-1)*rows;
        return empDao.findByPage(start,rows);
    }

    @Override
    public Long findTotals() {
        return empDao.findTotals();
    }

    @Override
    public void deleteRow(int id) {
        empDao.deleteRow(id);
    }

    @Override
    public void updateRow(Emp emp) {
        empDao.updateRow(emp);
    }

    @Override
    public Emp findOne(int id) {
        return empDao.queryOne(id);
    }

    @Override
    public void saveOne(Emp emp) {
        empDao.addOne(emp);
    }

    @Override
    public List<Emp> searchAll(String name) {
        return empDao.likeAll(name);
    }

    @Override
    public void removeMany(int[] ids) {
        empDao.delMany(ids);
    }


}
