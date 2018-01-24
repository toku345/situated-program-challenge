# == Schema Information
#
# Table name: meetups
#
#  id              :integer          not null, primary key
#  title           :text             not null
#  start_at        :datetime
#  end_at          :datetime
#  venue_id        :integer
#  group_id        :integer
#  online_venue_id :integer
#
# Indexes
#
#  meetups_title  (title)
#

FactoryBot.define do
  factory :meetup do
    title    { Faker::Movie.quote }
    start_at { Time.current + 2.weeks } # 2週間後
    end_at   { start_at + 1.hour }

    association :group, factory: :group
    association :venue, factory: :venue
  end
end
