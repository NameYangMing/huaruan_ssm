
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>登录</title>
    <script type="text/javascript" src="../jquery.js"></script>
    <script type="text/javascript">
        function change() {
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
                    if(r1===undefined){
                        document.getElementById("spanName").innerHTML=r2;
                    }else{
                        document.getElementById("spanName").innerHTML=r1;
                    }

                }
            })
        }
    </script>
</head>
<body>
    <h1>这是登录界面</h1>
    <form action="${pageContext.request.contextPath}/user/login" method="post">
        请输入用户名：<input type="text" name="username" id="username" onblur="change()">
                    <span id="spanName"></span><br>
        请输入密码：<input type="text" name="password"><br>
        <input type="submit" value="提交">
    </form>
</body>
</html>
