json.event_id meetup.id
json.title    meetup.title
json.start_at meetup.start_at.utc.strftime('%FT%H:%M:%S.%LZ') # `2018-01-16T00:27:42.798Z` スタイル
json.end_at   meetup.end_at.utc.strftime('%FT%H:%M:%S.%LZ')   # `2018-01-16T00:27:42.798Z` スタイル

json.venue do
  json.partial! 'partials/venue', venue: meetup.venue if meetup.venue
end

json.online_venue do
  json.partial! 'partials/online_venue', online_venue: meetup.online_venue if meetup.online_venue
end

json.members do
  json.array! meetup.members do |member|
    json.member_id  member.id
    json.first_name member.first_name
    json.last_name  member.last_name
    json.email      member.email
  end
end
