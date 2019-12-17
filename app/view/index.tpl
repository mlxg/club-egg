<html>
<head>
    <title>Egg Demo</title>
    <link href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.css" rel="stylesheet">
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
        <label class="col-md-6">
            <input class="form-control" type="text">
        </label>
        <div class="btn-group col-md-4" role="group" aria-label="Basic example">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-primary">查询</button>
            <button class="btn btn-primary">更新</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class=" my-3 p-3 bg-white rounded shadow-sm">
        <table class="table">
            <thead>
            <tr>

                <th scope="col">id</th>
                <th scope="col">name</th>
                <th scope="col">data</th>
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
    <div class="alert alert-primary" role="alert">
        A simple primary alert with <a href="#" class="alert-link">an example link</a>. Give it a click if you like.
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
                        alert('上传成功！');
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
                        alert('删除成功！');
                    }
                }
            });
        }
    });

    //reach
    $('button:eq(1)').on('click', function () {
        var data = $('input').val();
        if (data) {
            $.ajax({
                type: 'get',
                url: '/get/' + data,
                success: function (data) {
                    if (data) {

                        let str = '';
                        $('.table tbody').html().length && $('.table tbody').empty();
                        // alert('查询成功！');
                        $.each(data, (i, item) => {
                            str +=
                                ' <tr>' +
                                ' <th scope="row">' + i + '</th>' +
                                ' <td>' + item.name + '</td>' +
                                ' <td>' + item.data + '</td>' +
                                ' </tr>';
                        });

                        $('.table tbody').append(str);


                    }
                }
            });
        }
    });

    $('button:eq(2)').on('click', function () {
        var data = $('input').val();
        if (data) {
            $.ajax({
                type: 'get',
                url: '/update/' + data,
                success: function (data) {
                    if (data == 'success') {
                        alert('更新成功！');
                    }
                }
            });
        }
    });
</script>
</body>
</html>