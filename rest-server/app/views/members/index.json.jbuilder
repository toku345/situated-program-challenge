json.key_format! ->(key) { key.tr('_', '-') }
json.array! @members do |member|
  json.member_id  member.id
  json.first_name member.first_name
  json.last_name  member.last_name
  json.email      member.email
end
