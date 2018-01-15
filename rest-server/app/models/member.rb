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

class Member < ApplicationRecord
  has_many :groups_members
  has_many :groups, through: :groups_members
end
