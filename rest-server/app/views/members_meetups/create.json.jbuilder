json.key_format! ->(key) { key.tr('_', '-') }

json.partial! 'partials/meetup', meetup: @meetups_member.meetup
