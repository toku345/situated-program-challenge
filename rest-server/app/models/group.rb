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

class Group < ApplicationRecord
  has_many :groups_members
  has_many :members, through: :groups_members
end
