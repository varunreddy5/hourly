# class Notifications
#   constructor: ->
#     @notifications = $("[data-behavior = 'notifications']")
#     @setup() if @notifications.length > 0
  
#   setup: ->
#     $("[data-behavior='notifications-link']").on "click", (event) =>
      
#       $.ajax(
#         url: "/notifications/mark_as_read"
#         dataType: "JSON"
#         method: "POST"
#         beforeSend: (xhr) -> 
#           xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
#         success: ->
#           $("[data-behavior='unread-count']").text(0)
#       )
#     $.ajax(
#       url: "/notifications.json"
#       dataType: "JSON"
#       method: "GET"
#       success: (data) =>
        
#         items = $.map data, (notification) -> 
#           "<a class='dropdown-item' href='#'>#{notification.user} #{notification.action}</a>"
#         $("[data-behavior='unread-count']").text(items.length)
#         if items.length == 0
#           $("[data-behavior='notification-items']").html("<div>No new notifications</div>")
#         else
#           $("[data-behavior='notification-items']").html(items)
        
#     )


   

# jQuery -> 
#   new Notifications
