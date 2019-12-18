'use strict';
module.exports = app => {
    class HomeController extends app.Controller {
        * index() {
            yield this.ctx.render('index.tpl');
        }

        // 新增 同理构建基于router对应的控制器
        * add() {
            const data = this.ctx.request.body;
            console.log(data);
            const result = yield this.service.mysql.add(data.name);
            this.ctx.body = result;
        }

        * del() {
            const data = this.ctx.params.data;
            const result = yield this.service.mysql.del(data);
            this.ctx.body = result;
        }

        // 查询
        * reach() {
            const data = this.ctx.params.data;
            const result = yield this.service.mysql.reach(data);
            this.ctx.body = result;
        }

        * update() {
            const data = this.ctx.request.body;
            this.ctx.body = yield this.service.mysql.update(data);
        }

    }

    return HomeController;
};
