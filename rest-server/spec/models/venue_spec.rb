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

describe Venue, type: :model do
  # DB連携、factory_bot 設定などの確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:venue) }.to change(Venue, :count).by 1
  end
end
