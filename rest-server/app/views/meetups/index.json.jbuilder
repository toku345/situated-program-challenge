json.key_format! ->(key) { key.tr('_', '-') }

json.array! @meetups do |meetup|
  json.event_id meetup.id
  json.title    meetup.title
  json.start_at meetup.start_at.rfc3339 # `2018-01-16T00:27:42.798Z` スタイル
  json.end_at   meetup.end_at.rfc3339   # `2018-01-16T00:27:42.798Z` スタイル

  json.venue do
    json.partial! 'partials/venue', venue: meetup.venue
  end

  json.members do
    json.array! meetup.group.members do |member|
      json.member_id  member.id
      json.first_name member.first_name
      json.last_name  member.last_name
      json.email      member.email
    end
  end
end
