json.array! @notifications do |notification|
  # json.recipient notification.recipient
  json.user notification.user.name
  json.action notification.action
  json.notifiable notification.notifiable
end