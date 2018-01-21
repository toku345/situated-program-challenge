# == Schema Information
#
# Table name: meetups_members
#
#  meetup_id :integer          not null, primary key
#  member_id :integer          not null, primary key
#

require 'rails_helper'

describe MeetupsMember, type: :model do
  # factory_bot 設定の確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:meetups_member) }.to change(MeetupsMember, :count).by 1
  end
end
