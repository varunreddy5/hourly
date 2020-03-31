class Notifications
  constructor: ->
    @notifications = $("[data-behavior = 'notifications']")
    console.log("inside notifications.coffee")
    @setup() if @notifications.length > 0
  
  setup: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: (data) =>
        items = $.map data, (notification) -> 
          notification.template if notification.notifiable != null
        unread_count = 0
        $.each data, (notification) ->
          if notification.unread
            unread_count += 1
        
        $("[data-behavior='unread-count']").text(unread_count);
        $("[data-behavior='notification-items']").html(items);
    )

    $("[data-behavior='notifications-link']").on "click", (event) =>
      
      $.ajax(
        url: "/notifications/mark_as_read"
        dataType: "JSON"
        method: "POST"
        beforeSend: (xhr) -> 
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        success: ->
          $("[data-behavior='unread-count']").text(0)
          
      )



$(document).on "turbolinks:load", ->
  new Notifications
