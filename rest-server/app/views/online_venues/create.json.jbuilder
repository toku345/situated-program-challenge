json.key_format! ->(key) { key.tr('_', '-') }

json.partial! 'partials/online_venue', online_venue: @online_venue
