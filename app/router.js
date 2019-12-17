'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
// module.exports = app => {
//   const { router, controller } = app;
//   router.get('/', controller.home.index);
//
//
//
// };

module.exports = app => {
  app.get('/', 'home.index');
  app.get('/add/:data','home.add');
  app.get('/del/:data','home.del');
  app.get('/get/:data','home.reach');
  app.get('/update/:data','home.update');

};
