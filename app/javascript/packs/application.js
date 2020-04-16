// import 'core-js/stable';
// import 'regenerator-runtime/runtime';

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';
const application = Application.start();
const context = require.context('./controllers', true, /\.js$/);
application.load(definitionsFromContext(context));

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();

require('channels');
require('trix');
require('@rails/actiontext');
// require('jquery');
require('jquery-ui');
window.jQuery = window.$ = require('jquery');
require('../notifications');
require('../chatrooms');
// require('../cable');
import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import '../stylesheets/actiontext';
import '../stylesheets/application';

import '../stylesheets/posts';
import '../stylesheets/users';
import '../stylesheets/comments';
import '../stylesheets/shared/sidebar';
import '../stylesheets/chatrooms';
import '../stylesheets/direct_messages';
// import Trix from 'trix';

document.addEventListener('turbolinks:load', () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
  $('#_users_q').autocomplete({
    source: '/autocomplete',
    minlength: 2,
    select: function (event, ui) {
      location.href = '/users/' + ui.item.value;
    },
  });
});
