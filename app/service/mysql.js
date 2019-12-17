module.exports = app => {
    return class User extends app.Service {
        * add() {
            const data = this.ctx.params.data;
            // 表格名称test,数据库名称在config/config.default.js下已定义
            const result = yield this.app.mysql.insert('student', {
                // 时间优化下
                'data': new Date(+new Date() + 8 * 3600 * 1000).toISOString().replace(/T/g, ' ').replace(/\.[\d]{3}Z/, ''),
                'name': data
            });
            if (result.serverStatus == 2) {
                return 'success';
            } else {
                return 'fail';
            }
        }

        * del() {
            const data = this.ctx.params.data;
            const result = yield this.app.mysql.delete('student', {
                name: data
            });
            console.log('result.affectedRows  ' + result.affectedRows);
            if (result.affectedRows == 1) {
                return result;
            } else {
                return false;
            }
        }

        * reach() {
            const data = this.ctx.params.data;
            // get单条查询,select多条查询和全部 0这里表示查全部数据
            const result = data == 0
                ? yield this.app.mysql.select('student')
                : yield this.app.mysql.select('student', {
                    where: {name: data}, // WHERE 条件
                    columns: ['name', 'data'], // 要查询的表字段
                    orders: ['data'], // 排序方式
                    limit: 5,
                    offset: 0, // 数据偏移量
                });
            if (result) {
                return result;
            } else {
                return {
                    code: '1001',
                    data: 'false'
                };
            }
        }


        * update() {
            const data = this.ctx.params.data;
            console.log('更新数据' + data);
            const result = yield this.app.mysql.update('student', {
                id: '1',
                'name': 'ceshi'
            });

            if (result) {
                return result;
            } else {
                return {
                    code: '1001',
                    data: 'false'
                };
            }
        }
    };
};