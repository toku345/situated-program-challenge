# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  first_name :text
#  last_name  :text
#  email      :text
#
# Indexes
#
#  members_email  (email)
#

FactoryBot.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
  end
end
