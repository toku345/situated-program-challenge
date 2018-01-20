json.group_id   group.id
json.group_name group.name

json.admin do
  json.array!(admins) do |admin|
    json.partial! 'partials/admin', admin: admin
  end
end
