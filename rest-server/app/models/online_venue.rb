# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  name        :text
#  postal_code :text
#  prefecture  :text
#  city        :text
#  street1     :text
#  street2     :text
#  group_id    :integer
#  url         :text
#  venue_type  :enum             default("physical")
#
# Indexes
#
#  venues_name  (name)
#

class OnlineVenue < Venue
  after_create -> { self.venue_type = :online }
  default_scope -> { where(venue_type: 'online') }
end
