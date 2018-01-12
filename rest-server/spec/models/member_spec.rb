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

require 'rails_helper'

describe Member, type: :model do
  # DB連携、factory_bot 設定などの確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:member) }.to change(Member, :count).by 1
  end
end
