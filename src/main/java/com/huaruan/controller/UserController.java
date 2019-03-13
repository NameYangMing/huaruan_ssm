package com.huaruan.controller;

import com.huaruan.entity.User;
import com.huaruan.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RequestMapping("/user")
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/regist")
    public String regist(User user, HttpServletRequest request,String enCode) {
        if(user.getUsername()=="" || user.getPassword()==""){
            return "back/regist";
        }else {
            HttpSession session = request.getSession();
            //数据库账号
            User select = userService.selectUserame(user.getUsername());
            if (select == null) {
                userService.insert(user);
                //获取验证码
                Object validationCode = session.getAttribute("validationCode");
                if (validationCode.equals(enCode)) {
                    return "back/login";
                } else {
                    return "back/regist";
                }
            } else {
                if (select.getUsername().equals(user.getUsername())) {
                    return "back/regist";
                } else {
                    userService.insert(user);
                    //获取验证码
                    Object validationCode = session.getAttribute("validationCode");
                    if (validationCode.equals(enCode)) {
                        return "back/login";
                    } else {
                        return "back/regist";
                    }
                }
            }
        }

    }

    @RequestMapping("/login")
    public String login(User user){
        if(user.getUsername()=="" || user.getPassword()==""){
            return "back/login";
        }else{
            //输入框密码
            String password = user.getPassword();
            String s = DigestUtils.md5Hex(password);
            user.setPassword(s);
            User login = userService.login(user);
            if(login!=null){
                //数据库密码
                String pw = login.getPassword();
                System.out.println(pw);
                if(pw.equals(s)) {
                    return "back/home";
                }else{
                    return "back/login";
                }
            }else{
                return "back/login";
            }
        }
    }

    @RequestMapping("/selectUserName")
    public @ResponseBody Map<String,Object> selectUserName(String username){
        Map<String, Object> results = new HashMap<>();
        if(username==""){
            results.put("error","用户名不存在");
            return results;
        }else{
            User user = userService.selectUserame(username);
            if(user==null){
                results.put("error","用户名不存在");
                return results;
            }else{
                results.put("success","OK");
                return results;
            }
        }


    }



}
