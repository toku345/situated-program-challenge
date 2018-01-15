# == Schema Information
#
# Table name: groups_members
#
#  group_id  :integer          not null, primary key
#  member_id :integer          not null, primary key
#  admin     :boolean          default(FALSE)
#

FactoryBot.define do
  factory :groups_member do
    association :group,  factory: :group
    association :member, factory: :member
    admin false

    trait :admin do
      admin true
    end
  end
end
