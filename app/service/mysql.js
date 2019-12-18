module.exports = app => {
    return class User extends app.Service {
        async add() {
            const data = this.ctx.params.data;
            // 表格名称test,数据库名称在config/config.default.js下已定义
            const result = await this.app.mysql.insert('student', {
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

            const columns = 'id,name,data',
                table = 'student',
                sql = `select ${columns} from ${table} where name like "%${data}%"`;

            const result = data === 'all'
                ? yield this.app.mysql.select('student')
                : yield this.app.mysql.query(sql);

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
            const data = this.ctx.request.body;

            const query = `update student set name = ${data.name} where id = ${data.id}`;
            const result = yield this.app.mysql.query(query);

            if (result) {
                return {
                    data:'success'
                };
            } else {
                return {
                    code: '1001',
                    data: 'false'
                };
            }
        }

    };
};