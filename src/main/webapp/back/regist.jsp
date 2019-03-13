
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>注册</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery.js"></script>
    <script type="text/javascript">
        $(function(){
            //点击更换验证码：
            $("#captchaImage").click(function(){
                //点击更换验证码
                $("#captchaImage").attr("src","${pageContext.request.contextPath}/code?flag="+Math.random());
            });
        });
        //判断用户名 密码不能为空
        function check() {
            var name=$("#username").val();
            var pwd=$("#password").val();
            if(name=="" && pwd==""){
                document.getElementById("spanName").innerHTML="<font color='red'>请输入用户名</font>";
                document.getElementById("spanPwd").innerHTML="<font color='red'>请输入密码</font>";
                return false;
            }else{
                return true;
            }
        }
        //判断用户名是否存在
        function panduan() {
            var username=$("#username").val();
            $.ajax({
                type:"post",
                url:"${pageContext.request.contextPath}/user/selectUserName?",
                data:{username:username},
                dataType:"text",
                success:function (data) {
                    var r1=$.parseJSON(data).success;
                    var r2=$.parseJSON(data).error;
                    console.log("r1:"+r1);
                    console.log("r2:"+r2);
                    if(r1!==undefined){
                        document.getElementById("spanName").innerHTML="<font color='red'>用户名重复，请重新输入</font>";
                    }else{
                        document.getElementById("spanName").innerHTML="OK";

                    }

                }
            })
        }

    </script>
</head>
<body>
    <h1>这是注册页面</h1>
    <form action="${pageContext.request.contextPath}/user/regist" method="post" onsubmit="return check();">
        请输入用户名：<input type="text" name="username" id="username" onblur="panduan()">
                    <span id="spanName"></span><br>
        请输入密码：<input type="text" name="password" id="password">
                    <span id="spanPwd"></span><br>
        请输入验证码：<input type="text" id="enCode" name="enCode" class="text captcha" maxlength="4" autocomplete="off"/>
        <img id="captchaImage" class="captchaImage" src="${pageContext.request.contextPath}/code" title="点击更换验证码" style="top:10px;"/><br>
        <input type="submit" value="提交" >
    </form>

</body>
</html>
