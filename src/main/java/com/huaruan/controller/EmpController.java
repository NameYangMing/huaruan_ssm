package com.huaruan.controller;

import com.huaruan.entity.Emp;
import com.huaruan.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Emp")
public class EmpController {
    @Autowired
    private EmpService empService;

    //分页查询所有
    @RequestMapping("/findAll")
    public @ResponseBody Map<String,Object> findAll(String name, Integer page, Integer rows){
        Map<String, Object> results = new HashMap<>();
        if("".equals(name)){
            List<Emp> byPage = empService.findByPage(page, rows);
            Long totals = empService.findTotals();
            results.put("total",totals);
            results.put("rows",byPage);
        }else{
            //模糊查询
            List<Emp> emps = empService.searchAll(name);
            results.put("total",emps.size());
            results.put("rows",emps);
        }
        return  results;
    }

    //删除单条
    @RequestMapping("/deleteOne")
    public @ResponseBody Map<String,Object> deleteOne(int id){
        Map<String, Object> map = new HashMap<>();
        try{
            empService.deleteRow(id);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("message",e.getMessage());
        }
        return map;
    }

    //修改
    @RequestMapping("/updateOne")
    public @ResponseBody Map<String,Object> updateOne(Emp emp){
        Map<String, Object> map = new HashMap<>();
        try{
            empService.updateRow(emp);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("message",e.getMessage());
        }
        return map;
    }

    //查询单条
    @RequestMapping("/queryOne")
    public @ResponseBody Emp queryOne(int id){
        Emp one = empService.findOne(id);
        return one;
    }

    //添加
    @RequestMapping("/addOne")
    public @ResponseBody Map<String,Object> addOne(Emp emp){
        Map<String, Object> map = new HashMap<>();
        try {
            empService.saveOne(emp);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("message",e.getMessage());
        }
        return map;
    }

    //批量删除
    @RequestMapping("/delMany")
    public @ResponseBody Map<String,Object> delMany(int[] ids){
        Map<String, Object> map = new HashMap<>();
        try {
            empService.removeMany(ids);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
            map.put("message",e.getMessage());
        }
        return map;
    }


}
