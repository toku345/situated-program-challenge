# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime
#
# Indexes
#
#  groups_name  (name)
#

require 'rails_helper'

describe Group, type: :model do
  # factory_bot 設定の確認のための簡単なテスト
  it 'DBに正常に追加できること' do
    expect { create(:group) }.to change(Group, :count).by 1
  end

  describe '#admins' do
    let(:member) { create(:member) }
    let!(:group1) { create(:groups_member, :admin, member: member).group }
    let!(:group2) { create(:groups_member, :admin, member: member).group }

    it '同一ユーザが複数グループの管理者でも一人だけを返すこと' do
      expect(group1.admins.count).to be 1
    end
  end
end
