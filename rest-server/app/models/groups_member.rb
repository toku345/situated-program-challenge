# == Schema Information
#
# Table name: groups_members
#
#  group_id  :integer          not null, primary key
#  member_id :integer          not null, primary key
#  admin     :boolean          default(FALSE)
#

class GroupsMember < ApplicationRecord
  self.primary_keys = :group_id, :member_id

  belongs_to :group
  belongs_to :member
end
