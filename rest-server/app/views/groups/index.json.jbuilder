json.key_format! ->(key) { key.tr('_', '-') }

json.array! @groups do |group|
  json.group_id   group.id
  json.group_name group.name

  json.admin []
  json.venues []
  json.meetups []
end
