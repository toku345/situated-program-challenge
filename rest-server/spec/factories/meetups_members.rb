# == Schema Information
#
# Table name: meetups_members
#
#  meetup_id :integer          not null
#  member_id :integer          not null
#

FactoryBot.define do
  factory :meetups_member do
    association :meetup,  factory: :meetup
    association :member, factory: :member
  end
end
