# == Schema Information
#
# Table name: groups_members
#
#  group_id  :integer          not null, primary key
#  member_id :integer          not null, primary key
#  admin     :boolean          default(FALSE)
#

require 'rails_helper'

describe GroupsMember, type: :model do
  # factory_bot 設定の確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:groups_member) }.to change(GroupsMember, :count).by 1
  end

  it 'admin設定が正常にできること' do
    aggregate_failures do
      expect(create(:groups_member).admin).to be_falsey
      expect(create(:groups_member, :admin).admin).to be_truthy
    end
  end
end
