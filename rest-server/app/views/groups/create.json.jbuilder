json.key_format! ->(key) { key.tr('_', '-') }

json.group_id   @group.id
json.group_name @group.name

json.admin do
  json.array!(@admins) do |admin|
    json.member_id  admin.id
    json.first_name admin.first_name
    json.last_name  admin.last_name
    json.email      admin.email
  end
end
