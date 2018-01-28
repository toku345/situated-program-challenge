json.key_format! ->(key) { key.tr('_', '-') }

json.array! @online_venues do |online_venue|
  json.partial! 'partials/online_venue', online_venue: online_venue
end
