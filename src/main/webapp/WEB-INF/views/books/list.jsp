<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="page-header">
        <h3>图书列表</h3>
    </div>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <div>
        <form class="form-inline" method="get">
            <div class="form-group">
                <input class="form-control" type="text" placeholder="书籍名称" name="bookname" value="${bookname}">
            </div>
            <div class="form-group">
                <select class="form-control" name="typeid">
                    <option value="">请选择类型</option>
                    <c:forEach items="${bookTypeList}" var="type">
                        <option value="${type.id}" ${type.id == typeid ? 'selected' : ''}>${type.booktype}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <select class="form-control" name="pubid">
                    <option value="">请选择出版社</option>
                    <c:forEach items="${bookPubList}" var="pub">
                        <option value="${pub.id}" ${pub.id == pubid ? 'selected' : ''}>${pub.pubname}</option>
                    </c:forEach>
                </select>
            </div>
            <button class="btn btn-primary">搜索</button>
        </form>
    </div>
    <a class="btn btn-success" href="/books/new">添加新书</a>
    <table class="table">
        <thead>
        <tr>
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
        <c:forEach items="${page.items}" var="book">
            <tr>
                <td>${book.bookname}</td>
                <td>${book.bookauthor}</td>
                <td>${book.bookprice}</td>
                <td>${book.booknum}</td>
                <td>${book.publisher.pubname}</td>
                <td>${book.bookType.booktype}</td>
                <td>
                    <a href="/books/${book.id}/update">修改</a>
                    <a href="javaScript:;" date=${book.id} class="delLink">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <ul id="page" class="pagination"></ul>
</div>
<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="/static/js/jquery.twbsPagination.min.js"></script>
<script>
    $(function () {
        $(function () {
            $("#page").twbsPagination({
                totalPages:${page.totalPageSize},
                first: '首页',
                prev: '<<',
                next: '>>',
                last: '末页',
                visiblePages: 10,
                href: '?bookname=' + encodeURIComponent('${bookname}') + '&type=${typeid}&pub=${pubid}&p={{number}}'
            })
        });
        $(".delLink").click(function () {
            var id = $(this).attr("date");
            if (confirm("确定要删除吗？")) {
                window.location.href = "/books/" + id + "/del";
            }
        })
    })

</script>
</body>
</html>
