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

class Meetup < ApplicationRecord
  belongs_to :group
  belongs_to :venue,        class_name: 'PhysicalVenue', required: false, inverse_of: :meetups
  belongs_to :online_venue, class_name: 'OnlineVenue',   required: false, inverse_of: :meetups
  has_many :meetups_members, dependent: :destroy
  has_many :members, through: :meetups_members
end
