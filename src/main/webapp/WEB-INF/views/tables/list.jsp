<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/js/dataTables/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="/static/js/dataTables/css/dataTables.bootstrap.min.css">
</head>
<body>
<div class="container">
    <table id="dataTable" class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>书名</th>
            <th>作者</th>
            <th>价格</th>
            <th>总量</th>
            <th>出版社</th>
            <th>分类</th>
            <th>#</th>
        </tr>
        </thead>
        <tbody>
        <%--<c:forEach items="${bookList}" var="book">--%>
        <%--<tr>--%>
        <%--<td>${book.bookname}</td>--%>
        <%--<td>${book.bookauthor}</td>--%>
        <%--<td>${book.bookprice}</td>--%>
        <%--<td>${book.booknum}</td>--%>
        <%--<td>${book.publisher.pubname}</td>--%>
        <%--<td>${book.bookType.booktype}</td>--%>
        <%--<td>--%>
        <%--<a href="/books/${book.id}/update">修改</a>--%>
        <%--<a href="javaScript:;" date=${book.id} class="delLink">删除</a>--%>
        <%--</td>--%>
        <%--</tr>--%>
        <%--</c:forEach>--%>
        </tbody>
    </table>
</div>
<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="/static/js/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/js/dataTables/js/dataTables.bootstrap.min.js"></script>
<script>
    $(function () {
        $("#dataTable").DataTable({
            "serverSide": true,
            "ajax": "/dataTable/data.json",
            "columns": [
                {"data": "id", "name": "id"},
                {"data": "bookname", "name": "bookname"},
                {"data": "bookauthor", "name": "bookauthor"},
                {"data": "bookprice", "name": "bookprice"},
                {"data": "booknum", "name": "booknum"},
                {"data": "publisher.pubname", "name": "pubid"},
                {"data": "bookType.booktype", "name": "typeid"},
                {
                    "data": function () {
                        return "#"
                    }
                }
            ],
            "columnDefs": [
                {targets: [0], visible: false},
                {targets: [1, 2, 5, 7], orderable: false}
            ],
            "language": {
                "search": "查找",
                "zeroRecords": "没有匹配的数据",
                "lengthMenu": "显示 _MENU_ 条数据",
                "info": "显示从 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                "infoFiltered": "(从 _MAX_ 条数据中查询结果)",
                "loadingRecords": "加载中...",
                "processing": "处理中...",
                "paginate": {
                    "first": "首页",
                    "last": "末页",
                    "next": "下一页",
                    "previous": "上一页"

                }
            }
        });
    })
</script>
</body>
</html>
