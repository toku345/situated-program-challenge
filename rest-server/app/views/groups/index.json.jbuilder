json.key_format! ->(key) { key.tr('_', '-') }

json.array! @groups do |group|
  json.partial! 'partials/group', group: group, admins: group.admins

  json.venues do
    json.array!(group.venues) do |venue|
      json.partial! 'partials/venue', venue: venue
    end
  end

  json.meetups do
    json.array!(group.meetups) do |meetup|
      json.partial! 'partials/meetup', meetup: meetup
    end
  end
end
