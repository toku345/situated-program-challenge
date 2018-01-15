json.key_format! ->(key) { key.tr('_', '-') }

json.array! @venues do |venue|
  json.partial! 'partials/venue', venue: venue
end
