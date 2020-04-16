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
    console.log(active_chatroom, active_chatroom.length);
    if (active_chatroom.length > 0) {
      console.log('inside if', active_chatroom.length);
      active_chatroom.append(data.message);
    } else {
      $(
        "[data-behavior='messages'][data-chatroom-id=" + data.chatroom_id + ']'
      ).css('font-weight', 'bold');
    }
  },

  send_message: function (chatroom_id, message) {
    console.log('inside send message function', chatroom_id, message);
    this.perform('send_message', {
      chatroom_id: chatroom_id,
      body: message,
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
    var body = $('#message_body');
    chatrooms.send_message(chatroom_id, body.val());
    body.val('');
    $('#messages-section').scrollTo(100);
  });
};
