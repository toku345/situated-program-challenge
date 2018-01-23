json.key_format! ->(key) { key.tr('_', '-') }

# json.array! @venues do |venue|
#   json.partial! 'partials/venue', venue: venue
# end

json.array! @online_venues do |online_venue|
  json.online_venue_id online_venue.id
  json.venue_name      online_venue.name
  json.url             online_venue.url
end
