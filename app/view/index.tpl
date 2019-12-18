<!DOCTYPE html>
<head>
    <title>Egg Demo</title>
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/twitter-bootstrap/4.3.1/css/bootstrap-grid.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<main role="main" class="container">
    <nav aria-label="breadcrumb" class="bg-white">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><a href="#">Library</a></li>
            <li class="breadcrumb-item active" aria-current="page">Data</li>
        </ol>
    </nav>

    <div class=" my-3 p-3 bg-white rounded shadow-sm">
        <label class="col-md-12">
            <input class="form-control" type="text">
        </label>
        <div class=" col-md-4" role="group" aria-label="Basic example">
            <button class="btn  btn-outline-primary">新增</button>
            <button class="btn  btn-outline-primary">查询</button>
            <!--            <button class="btn  btn-outline-primary">更新</button>-->
            <button class="btn btn-danger">批量删除</button>
        </div>
    </div>
    <div class=" my-3 p-3 bg-white rounded shadow-sm">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th scope="col" width="15%">id</th>
                <th scope="col" width="30%">name</th>
                <th scope="col" width="25%">creatDate</th>
                <th scope="col" width="15%">edit</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="btn-toolbar" role="toolbar" aria-label="Toolbar with button groups">
        <div class="btn-group mr-2" role="group" aria-label="First group">
            <button type="button" class="btn btn-secondary">1</button>
            <button type="button" class="btn btn-secondary">2</button>
            <button type="button" class="btn btn-secondary">3</button>
            <button type="button" class="btn btn-secondary">4</button>
        </div>
    </div>
</main>

<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    $('button:eq(0)').click(function () {
        var data = $('input').val();
        if (data) {
            $.ajax({
                type: 'get',
                url: '/add/' + data,
                success: function (data) {
                    if (data == 'success') {
                        reload();
                    }
                }
            });
        }
    });

    $('button:eq(3)').on('click', function () {
        var data = $('input').val();
        if (data) {
            $.ajax({
                type: 'get',
                url: '/del/' + data,
                success: function (data) {
                    if (data == 'success') {

                        reload();
                    }
                }
            });
        }
    });

    //reach
    $('button:eq(1)').on('click', function () {
        var data = $('input').val();
        reload(data);
    });


    $('button:eq(2)').on('click', function () {
        var data = $('input').val();
        if (data) {
            $.ajax({
                type: 'post',
                url: '/update.do',
                data: {name: data},
                success: function (data) {
                    if (data == 'success') {
                        reload();
                    }
                }
            });
        }
    });

    function update(e) {
        var id = $(e).closest('tr').find('.id').html();
        var name = $(e).closest('tr').find('[name=new]').val();

        var postData = {
            id: id,
            name: name
        };

        $.ajax({
            type: 'post',
            url: '/update.do',
            data: postData,
            success: function (data) {
                console.log(data);
                if (data.data === 'success') {
                    reload();
                }
            }
        });
    }


    function edit(e) {
        $(e).closest('tr').find('[data-type=read]').hide();
        $(e).closest('tr').find('[data-type=edit]').show();
        $(e).hide();
        $(e).siblings('.update').hide();
        $(e).siblings('.save,.cancel').show();
    }

    function cancel(e) {
        $(e).closest('tr').find('[data-type=read]').show();
        $(e).closest('tr').find('[data-type=edit]').hide();
        $(e).hide();
        $(e).siblings('.update').show();
        $(e).siblings('.save,.cancel').hide();
    }


    function reload(param) {
        let req = param || 'all';
        $.ajax({
            type: 'get',
            url: '/get/' + req,
            success: function (data) {
                if (data) {
                    let str = '';
                    $('.table tbody').html().length && $('.table tbody').empty();

                    $.each(data, (i, item) => {
                        str +=
                            ' <tr>' +
                            ' <td class="id">' + item.id + '</td>' +
                            ' <td>' +
                            '<span data-type="read" >' + item.name + '</span>' +
                            '<input style="display: none" data-type="edit" class="form-control" type="text" value="' + item.name + '" name="new"></td>' +
                            ' <td>' + item.data + '</td>' +
                            ' <td>' +
                            '<div class="" role="group" aria-label="Basic example">' +
                            '<button class="btn  btn-warning update" style="margin-right: 8px" onclick="edit(this)">更新</button>' +
                            '<button style="display: none; margin-right: 8px" class="btn  btn-outline-primary save"  onclick="update(this)" >保存</button>' +
                            '<button style="display: none" class="btn  btn-outline-primary cancel" onclick="cancel(this)" >取消</button>' +
                            '</div>' +
                            '</td>' +


                            ' </tr>';
                    });

                    $('.table tbody').append(str);


                }
            }
        });
    }

    reload();


</script>
</body>
<html>