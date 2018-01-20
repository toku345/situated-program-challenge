json.key_format! ->(key) { key.tr('_', '-') }

json.array! @members do |member|
  json.partial! 'partials/member', member: member
end
