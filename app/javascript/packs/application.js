// import 'core-js/stable';
// import 'regenerator-runtime/runtime';

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

const application = Application.start();
const context = require.context('./controllers', true, /\.js$/);
application.load(definitionsFromContext(context));

require('trix');
require('@rails/actiontext');
require('jquery-ui');

import 'bootstrap';
import '../stylesheets/application';
document.addEventListener('turbolinks:load', () => {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-toggle="popover"]').popover();
});

$(function() {
  $('#_users_q').autocomplete({
    source: 'users/autocomplete',
    minlength: 2
  });
});
