# == Schema Information
#
# Table name: meetups_members
#
#  meetup_id :integer          not null, primary key
#  member_id :integer          not null, primary key
#

class MeetupsMember < ApplicationRecord
  self.primary_keys = :meetup_id, :member_id

  belongs_to :meetup
  belongs_to :member
end
