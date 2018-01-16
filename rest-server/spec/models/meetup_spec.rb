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

require 'rails_helper'

describe Meetup, type: :model do
  # DB連携、factory_bot 設定などの確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:meetup) }.to change(Meetup, :count).by 1
  end
end
