import consumer from './consumer';

const chatrooms = consumer.subscriptions.create('ChatroomsChannel', {
  connected: function () {},

  disconnected: function () {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    console.log(data);

    var active_chatroom = $(
      "[data-behavior='messages'][data-chatroom-id=" + data.chatroom_id + ']'
    );
    console.log(active_chatroom, active_chatroom.length, 'Final result');
    if (active_chatroom.length > 0) {
      console.log('data chatroom id', data.chatroom_id);
      active_chatroom.append(data.message);
    } else {
      $(
        "[data-behavior='messages'][data-chatroom-id=" + data.chatroom_id + ']'
      ).css('color', 'red');
    }
  },

  send_message: function (chatroom_id, message, current_u) {
    console.log('inside send message function', chatroom_id, message);
    this.perform('send_message', {
      chatroom_id: chatroom_id,
      body: message,
      current_u: current_u
    });
  },
});

var submit_messages;
$(document).on('turbolinks:load', function () {
  submit_messages();
});

submit_messages = function () {
  $('#new_message').on('keypress', function (e) {
    if (e && e.keyCode == 13) {
      e.preventDefault();
      $(this).submit();
    }
  });

  $('#new_message').on('submit', function (e) {
    e.preventDefault();
    var chatroom_id = $("[data-behavior = 'messages']").data('chatroom-id');
    var current_user = $("#current_user").text()
    var body = $('#message_body');
    chatrooms.send_message(chatroom_id, body.val(), current_user);
    body.val('');
  });
};
