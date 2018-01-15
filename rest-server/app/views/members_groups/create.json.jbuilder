json.key_format! ->(key) { key.tr('_', '-') }

group = @groups_member.group

json.group_id   group.id
json.group_name group.name

members = group.members
admin_members = members.joins(:groups_members).where(groups_members: { admin: true })

json.admin do
  json.array!(admin_members) do |member|
    json.member_id  member.id
    json.first_name member.first_name
    json.last_name  member.last_name
    json.email      member.email
  end
end

json.venues do
  json.array!(group.venues) do |venue|
    json.partial! 'partials/venue', venue: venue
  end
end
json.meetups []
