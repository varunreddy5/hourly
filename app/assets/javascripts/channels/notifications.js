App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  connected: function() {
    console.log('connected');
    // $("[data-behavior='unread-count']").text(data.count);
    // Called when the subscription is ready for use on the server
    getNotifications();
    $("[data-behavior='notifications-link']").on('click', function(event) {
      read = getNotifications();
      if (read) {
        postUnReadNotifications();
      }
    });
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    $("[data-behavior='unread-count']").text(data.count);
    // $("[data-behavior='notification-items']").prepend(data.html);
    // $("[data-behavior='notifications-link']").on('click', function(event) {
    //   getNotifications();
    //   postUnReadNotifications();
    // });
  }
});

function getNotifications() {
  $.ajax({
    url: '/notifications.json',
    dataType: 'JSON',
    method: 'GET',
    success: function(data) {
      $("[data-behavior='unread-count']").text(data.length);
      items = $.map(data, function(notification) {
        return (
          "<a class='dropdown-item' href='#'>" +
          notification.user +
          ' ' +
          notification.action +
          '</a>'
        );
      });
      if (items.length == 0) {
        $("[data-behavior='notification-items']").html(
          "<div class='text-center'>No new notifications</div>"
        );
      } else {
        $("[data-behavior='notification-items']").html(items);
      }
    }
  });
  return true;
}

function postUnReadNotifications() {
  $.ajax({
    url: '/notifications/mark_as_read',
    dataType: 'JSON',
    method: 'POST',
    beforeSend: function(xhr) {
      xhr.setRequestHeader(
        'X-CSRF-Token',
        $('meta[name="csrf-token"]').attr('content')
      );
    },
    success: function() {
      $("[data-behavior='unread-count']").text(0);
    }
  });
}
