json.key_format! ->(key) { key.tr('_', '-') }

json.partial! 'partials/member', member: @member
