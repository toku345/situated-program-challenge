# == Schema Information
#
# Table name: meetups
#
#  id       :integer          not null, primary key
#  title    :text             not null
#  start_at :datetime
#  end_at   :datetime
#  venue_id :integer
#  group_id :integer
#
# Indexes
#
#  meetups_title  (title)
#

class Meetup < ApplicationRecord
  belongs_to :group
  belongs_to :venue
  has_many :meetups_members, dependent: :destroy
  has_many :members, through: :meetups_members
end
