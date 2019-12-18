'use strict';
module.exports = app => {
    app.get('/', 'home.index');
    app.get('/add/:data', 'home.add');
    app.get('/del/:data', 'home.del');
    app.get('/get/:data', 'home.reach');

    app.post('/update.do', 'home.update');

};
