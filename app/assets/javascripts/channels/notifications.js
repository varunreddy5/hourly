App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  connected: function() {
    // getNotificationsData();
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
    $("[data-behavior='unread-count']").text(data.count);
    $("[data-behavior='notification-items']").prepend(data.html);
  }
});

// function getNotificationsData() {
//   $.ajax({
//     url: '/notifications.json',
//     dataType: 'JSON',
//     method: 'GET',
//     success: function(data) {
//       // console.log(data);
//       items = $.map(data, function(notification) {
//         return notification.template;
//       });
//       console.log(items);
//       unread_count = 0;
//       $.each(data, function(notification) {
//         if (notification.unread) {
//           unread_count += 1;
//         }
//       });
//       $("[data-behavior='unread-count']").text(unread_count);
//       $("[data-behavior='notification-items']").html(items);
//     }
//   });
// }

// function postUnreadNotifications() {
//   $.ajax({
//     url: '/notifications/mark_as_read',
//     dataType: 'JSON',
//     method: 'POST',
//     beforeSend: function(xhr) {
//       xhr.setRequestHeader(
//         'X-CSRF-Token',
//         $('meta[name="csrf-token"]').attr('content')
//       );
//     },
//     success: function() {
//       console.log('posted');
//       $("[data-behavior='unread-count']").text(0);
//     }
//   });
// }
