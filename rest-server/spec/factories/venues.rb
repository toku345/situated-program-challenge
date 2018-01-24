# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  name        :text
#  postal_code :text
#  prefecture  :text
#  city        :text
#  street1     :text
#  street2     :text
#  group_id    :integer
#  url         :text
#  venue_type  :enum             default("physical")
#
# Indexes
#
#  venues_name  (name)
#

FactoryBot.define do
  factory :venue do
    sequence(:name) { |n| "Venue #{n}" }

    postal_code { Faker::Address.postcode }
    prefecture  { Faker::Address.state }
    city        { Faker::Address.city }
    street1     { Faker::Address.street_address }
    street2     { Faker::Address.secondary_address }

    association :group, factory: :group
  end
end
