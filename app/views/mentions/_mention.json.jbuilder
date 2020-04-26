json.extract! mention, :id, :name, :username

json.sgid mention.attachable_sgid
json.content render(partial: 'mentions/mention', locals: { mention: mention }, formats: [:html])