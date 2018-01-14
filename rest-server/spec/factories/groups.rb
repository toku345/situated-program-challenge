# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime
#
# Indexes
#
#  groups_name  (name)
#

FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "GROUP#{n}" }
  end
end
