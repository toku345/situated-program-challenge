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

require 'rails_helper'

describe PhysicalVenue, type: :model do
  it '適切なvennue_typeでDBに正常に追加できること' do
    aggregate_failures do
      expect { create(:physical_venue) }.to change(PhysicalVenue, :count).by 1
      expect(PhysicalVenue.first.venue_type).to eq 'physical'
    end
  end
end
