json.key_format! ->(key) { key.tr('_', '-') }

json.venue_id   @venue.id
json.venue_name @venue.name

json.address do
  json.postal_code @venue.postal_code
  json.prefecture  @venue.prefecture
  json.city        @venue.city
  json.address1    @venue.street1
  json.address2    @venue.street2
end
