<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/black/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {
            var name;
            $("#pp").datagrid({
                url:"${pageContext.request.contextPath}/Emp/findAll",
                fitColumns:true,//真正的自动展开/收缩列的大小，防止水平滚动
                resizehandle:'left',//调整列的位置，可用的值有：'left','right','both'
                autoRowHeight:true,//定义设置行的高度，根据该行的内容。设置为false可以提高负载性能。
                striped:true,//斑马线效果
                toolbar:'#tb',//显示头部标签
                rownumbers:true,//显示行列号
                pagination:true,//显示分页工具栏
                remoteSort:false,//关闭服务器排序
                pageSize:5,//每页显示记录数
                pageList:[2,5,10,15,30],
                //请求远程数据时发送额外参数
                queryParams:{
                    name:$("#name").val(),
                },
                //在数据请求发送之前，将输入框的内容重新发送
                onBeforeLoad:function(param){
                    //console.log(param);
                    param.name=$("#name").val();
                },
                columns:[[
                    {title:"cks",field:"cks",checkbox:true},
                    {title:"ID",field:"id"},
                    {title:"Name",field:"name"},
                    {title:"Age",field:"age",sortable:true,order:'asc'},
                    {title:"Address",field:"address"},
                    {title:"Birthday",field:"birthday"},
                    {title:"options",field:"options",width:200,
                    formatter:function (value,row,index) {
                        return "<a href='javascript:;' class='bb' onclick=\"delRow('"+row.id+"')\" " +
                            "data-options=\"iconCls:'icon-remove'\">删除</a>&nbsp;&nbsp;" +
                            "<a href='javascript:;' class='bb' onclick=\"openEditUserDialog('"+row.id+"')\" " +
                            "data-options=\"iconCls:'icon-edit'\">修改</a>"
                    }}
                ]],
                onLoadSuccess:function () {
                    $(".bb").linkbutton();
                    $('#pp').datagrid('fixRowHeight');
                }

            })
        });
        //删除一行
        function delRow(id) {
            //获取当前点击的id 发送ajax请求 删除该id信息
            $.post("${pageContext.request.contextPath}/Emp/deleteOne",{"id":id},
                function (result) {//请求成功之后的回调函数
                    if(result.success){
                        //提示修改信息
                        $.messager.show({title:'提示',msg:'删除成功！'});
                    }else{
                        //提示修改信息
                        $.messager.show({title:'提示',msg:result.message});
                    }
                    //刷新datagrid数据
                    $("#pp").datagrid('reload');//刷新当前datagrid//
                });
        }
        //修改一行事件  打开修改用户信息对话框
        function openEditUserDialog(id) {
            $("#editUserDialog").dialog({
                href:'${pageContext.request.contextPath}/back/update.jsp?id='+id,
                buttons:[
                    {
                        iconCls:'icon-save',
                        text:'修改',
                        handler:function () {
                            $("#updataUser").form('submit',{
                                url:'${pageContext.request.contextPath}/Emp/updateOne',
                                success:function (result) {//注意一定是json字符串  需要转成js对象
                                    var resultObj = $.parseJSON(result);
                                    console.log(resultObj);
                                    if(resultObj.success){
                                        //提示修改信息
                                        $.messager.show({title:'提示',msg:'用户信息修改成功！'});
                                    }else{
                                        //提示修改信息
                                        $.messager.show({title:'提示',msg:resultObj.message});
                                    }
                                    //关闭dialog
                                    $("#editUserDialog").dialog('close');
                                    //刷新dislog
                                    $("#pp").datagrid('reload');
                                }
                            })
                        }
                    },{
                        iconCls:'icon-cancel',
                        text:'取消',
                        handler:function () {
                            //关闭dialog
                            $("#editUserDialog").dialog('close');
                        }
                    }
                ]
            })
        }
        //添加一行事件  打开添加用户信息对话框
        function openSaveUserDialog() {
            $("#saveUserDialog").dialog({
                buttons:[{
                    iconCls:'icon-save',
                    text:'保存',
                    handler:function () {
                        //保存用户信息
                        $("#saveUser").form('submit',{
                            url:'${pageContext.request.contextPath}/Emp/addOne',
                            success:function (result) {
                                //响应的是json格式字符串 因该先转换为js对象
                                var resultObj = $.parseJSON(result);
                                if(resultObj.success){
                                    //提示信息
                                    $.messager.show({title:'提示',msg:'用户添加成功！'});
                                }else{
                                    //提示信息
                                    $.messager.show({title:'提示',msg:resultObj.message});
                                }
                                //关闭对话框
                                $("#saveUserDialog").dialog('close');
                                //刷新diagird
                                $("#pp").datagrid('reload');
                            }
                        })
                    }
                },{
                    iconCls:'icon-cancel',
                    text:'取消',
                    handler:function () {
                        //关闭dialog
                        $("#saveUserDialog").dialog('close');
                    },
                }]
            })
        };

        //模糊查询
        function searchMath() {
            $("#pp").datagrid('reload');
        }

        //批量删除
        function delBatchRows() {
            //获取选中的对象
            var rows=$("#pp").datagrid('getSelections');
            //console.log(rows);
            //判断是否选中
            if(rows.length<=0){
                $.messager.show({title:'提示',msg:'至少选中一行！'});
            }else{
                var a=[];
                //遍历数组对象rows  将id存放进空数组a
                for(i=0;i<rows.length;i++){
                    //console.log(rows[i].id);
                    a.push(rows[i].id);
                }
                //console.log(a);
                $.ajax({
                    type:"POST",
                    url:"${pageContext.request.contextPath}/Emp/delMany",
                    data:{"ids":a},
                    traditional:true,
                    success:function (result) {
                        //console.log(result);
                        if(result.success){
                            //提示信息
                            $.messager.show({title:'提示',msg:'删除成功！'});
                        }else{
                            //提示信息
                            $.messager.show({title:'提示',msg:result.message});
                        }
                        //刷新diagird
                        $("#pp").datagrid('reload');
                    }
                })
            }

        }

    </script>
</head>
<body>
    <div style="margin: auto;width: 600px;">
        <h1 style="margin-left: 170px;">欢迎来到首页</h1>
        <%--表格--%>
        <table id="pp" class="easyui-datagrid"></table>
    </div>

    <%--标签--%>
    <div id="tb">
        <a href="javascript:;" onclick="openSaveUserDialog();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
        <a href="javascript:;" onclick="delBatchRows();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">批量删除</a>
        <%--模糊查询--%>
        <input type="text" id="name"  name="name" class="easyui-textbox">
        <input type="submit" onclick="searchMath()" value="搜索" class="easyui-linkbutton" data-options="width:50,height:25,">
    </div>

    <%--添加用户--%>
    <div id="saveUserDialog" data-options="closable:false,href:'${pageContext.request.contextPath}/back/save.jsp',draggable:false,width:400,height:300,title:'保存用户信息'"></div>

    <%--修改用户信息--%>
    <div id="editUserDialog" data-options="closable:false,draggable:false,width:500,height:300,iconCls:'icon-edit',title:'更新用户信息'"></div>


</body>
</html>
