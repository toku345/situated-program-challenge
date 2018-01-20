json.key_format! ->(key) { key.tr('_', '-') }

json.partial! 'partials/group', group: @group, admins: @admins
