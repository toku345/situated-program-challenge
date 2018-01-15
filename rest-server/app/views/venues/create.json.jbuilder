json.key_format! ->(key) { key.tr('_', '-') }

json.partial! 'partials/venue', venue: @venue
