json.key_format! ->(key) { key.tr('_', '-') }

json.array! @meetups do |meetup|
  json.partial! 'partials/meetup', meetup: meetup
end
