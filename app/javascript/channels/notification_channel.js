import consumer from './consumer';

consumer.subscriptions.create('NotificationsChannel', {
  connected: function() {
    $("[data-behavior='notifications-link']").on('click', function(event) {
      console.log('clicked');
      // getNotificationsData();
      // postUnreadNotifications();
    });
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log(data);
    $("[data-behavior='unread-count']").text(data.count);
    $("[data-behavior='notification-items']").prepend(data.html);
  }
});
