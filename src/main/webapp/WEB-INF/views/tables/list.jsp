<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="/static/js/dataTables/css/dataTables.bootstrap.min.css">
</head>
<body>
<div class="container">
    <div class="page-header">
        <h3>书籍列表</h3>
    </div>
    <a class="btn btn-success" href="javaScript:;" id="addBookBtn" style="margin-bottom: 20px">添加新书籍</a>
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

        </tbody>
    </table>
</div>

<%--addModal--%>
<div class="modal fade" id="addModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加新书籍</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" id="addForm">
                    <div class="form-group">
                        <label>书籍名称</label>
                        <input class="form-control" type="text" name="bookname">
                    </div>
                    <div class="form-group">
                        <label>书籍作者</label>
                        <input class="form-control" type="text" name="bookauthor">
                    </div>
                    <div class="form-group">
                        <label>书籍价格</label>
                        <input class="form-control" type="text" name="bookprice">
                    </div>
                    <div class="form-group">
                        <label>书籍数量</label>
                        <input class="form-control" type="text" name="booknum">
                    </div>
                    <div class="form-group">
                        <label>书籍类型</label>
                        <select name="typeid" class="form-control">
                            <c:forEach items="${bookTypeList}" var="type">
                                <option value="${type.id}">${type.booktype}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>书籍出版社</label>
                        <select class="form-control" name="pubid">
                            <c:forEach items="${bookPubList}" var="pub">
                                <option value="${pub.id}">${pub.pubname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--updateModel--%>
<div class="modal fade" id="updateModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改书籍信息</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" id="updateForm">
                    <input class="hidden" id="update_bookid" name="id">
                    <div class="form-group">
                        <label>书籍名称</label>
                        <input class="form-control" type="text" name="bookname" id="update_bookname">
                    </div>
                    <div class="form-group">
                        <label>书籍作者</label>
                        <input class="form-control" type="text" name="bookauthor" id="update_bookauthor">
                    </div>
                    <div class="form-group">
                        <label>书籍价格</label>
                        <input class="form-control" type="text" name="bookprice" id="update_bookprice">
                    </div>
                    <div class="form-group">
                        <label>书籍数量</label>
                        <input class="form-control" type="text" name="booknum" id="update_booknum">
                    </div>
                    <div class="form-group">
                        <label>书籍类型</label>
                        <select name="typeid" class="form-control" id="update_typeid">
                            <c:forEach items="${bookTypeList}" var="type">
                                <option value="${type.id}">${type.booktype}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>书籍出版社</label>
                        <select class="form-control" name="pubid" id="update_pubid">
                            <c:forEach items="${bookPubList}" var="pub">
                                <option value="${pub.id}">${pub.pubname}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="updateBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<script src="/static/js/jquery-1.11.3.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/dataTables/js/jquery.dataTables.min.js"></script>
<script src="/static/js/dataTables/js/dataTables.bootstrap.min.js"></script>
<script src="/static/js/jquery.validate.js"></script>
<script>
    $(function () {
        var dataTable = $("#dataTable").DataTable({
            "lengthMenu": [5, 10, 15, 20],
            "serverSide": true,
            "ajax": "/dataTable/data.json",
            "order": [0, 'desc'],
            "columns": [
                {"data": "id", "name": "id"},
                {"data": "bookname", "name": "bookname"},
                {"data": "bookauthor", "name": "bookauthor"},
                {"data": "bookprice", "name": "bookprice"},
                {"data": "booknum", "name": "booknum"},
                {"data": "publisher.pubname", "name": "pubid"},
                {"data": "bookType.booktype", "name": "typeid"},
                {
                    "data": function (row) {
                        return "<a hred='javaScript:;' class='updateLink' data='" + row.id + "'>修改</a>" +
                                "<a href='javaScript:;' class='delLink' data='" + row.id + "'>删除</a>"
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

        //添加新书籍
        $("#addForm").validate({
            errorElement: "span",
            errorClass: "text-danger",
            rules: {
                bookname: {
                    required: true
                },
                bookauthor: {
                    required: true
                },
                bookprice: {
                    required: true,
                    number: true

                },
                booknum: {
                    required: true,
                    digits: true
                }
            },
            messages: {
                bookname: {
                    required: "请输入书籍名称"
                },
                bookauthor: {
                    required: "请输入作者"
                },
                bookprice: {
                    required: "请输入价格",
                    number: "请输入正确的价格"
                },
                booknum: {
                    required: "请输入数量",
                    digits: "请输入正确的数量"
                }
            },
            submitHandler: function (form) {
                $.post("/dataTable/addBook", $(form).serialize())
                        .done(function (data) {
                            if (data == "success") {
                                $("#addModal").modal('hide');
                                dataTable.ajax.reload();
                            }
                        })
                        .fail(function () {
                            alert("请求服务器异常");
                        })
            }

        });
        $("#addBookBtn").click(function () {
            $("#addModal").modal({
                show: true,
                backdrop: 'static',
                keyboard: false
            });
        });
        $("#saveBtn").click(function () {
            $("#addForm").submit();

        });

        //删除书籍
        $(document).delegate(".delLink", "click", function () {
            var id = $(this).attr("data");
            if (confirm("确认要删除吗？")) {
                $.get("/dataTable/" + id + "/del")
                        .done(function (data) {
                            if (data == "success") {
                                dataTable.ajax.reload();
                            }
                        }).fail(function () {
                    alert("请求服务器异常")
                });
            }
        });

        //修改书籍
        $(document).delegate(".updateLink", "click", function () {
            var id = $(this).attr("data");
            $.get("/dataTable/" + id + "/update.json").done(function (data) {
                $("#update_bookid").val(data.id);
                $("#update_bookname").val(data.bookname);
                $("#update_bookauthor").val(data.bookauthor);
                $("#update_bookprice").val(data.bookprice);
                $("#update_booknum").val(data.booknum);
                $("#update_pubid").val(data.pubid);
                $("#update_typeid").val(data.typeid);

                $("#updateModal").modal({
                    show: true,
                    backdrop: 'static',
                    keyboard: false
                });

            }).fail(function () {
                alert("请求服务器异常")
            });

            $("#updateBtn").click(function () {
                $("#updateForm").submit();
            });

            $("#updateForm").validate({
                errorElement: "span",
                errorClass: "text-danger",
                rules: {
                    bookname: {
                        required: true
                    },
                    bookauthor: {
                        required: true
                    },
                    bookprice: {
                        required: true,
                        number: true

                    },
                    booknum: {
                        required: true,
                        digits: true
                    }
                },
                messages: {
                    bookname: {
                        required: "请输入书籍名称"
                    },
                    bookauthor: {
                        required: "请输入作者"
                    },
                    bookprice: {
                        required: "请输入价格",
                        number: "请输入正确的价格"
                    },
                    booknum: {
                        required: "请输入数量",
                        digits: "请输入正确的数量"
                    }
                },
                submitHandler: function (form) {
                    $.post("/dataTable/updateBook", $(form).serialize())
                            .done(function (data) {
                                if (data == "success") {
                                    $("#updateModal").modal('hide');
                                    dataTable.ajax.reload();
                                }
                            })
                            .fail(function () {
                                alert("请求服务器异常");
                            })
                }
            });


        })


    })
</script>
</body>
</html>
