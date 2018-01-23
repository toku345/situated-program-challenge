require 'rails_helper'

describe 'online-venues API', type: :request do
  describe 'GET /groups/{group-id}/online-venues' do
    let(:group1) { create(:group) }
    let(:group2) { create(:group) }

    let!(:physical_venue1_1) { create(:physical_venue, group: group1) } # これは含まれないはず
    let!(:online_venue1_1)   { create(:online_venue, group: group1) }
    let!(:online_venue1_2)   { create(:online_venue, group: group1) }
    let!(:online_venue2_1)   { create(:online_venue, group: group2) }

    let(:expected_response_body) do
      [
        {
          'online-venue-id' => online_venue1_1.id,
          'venue-name'      => online_venue1_1.name,
          'url'             => online_venue1_1.url
        },
        {
          'online-venue-id' => online_venue1_2.id,
          'venue-name'      => online_venue1_2.name,
          'url'             => online_venue1_2.url
        }
      ]
    end

    it '指定したグループに紐づく会場一覧を取得できること' do
      aggregate_failures do
        get "/groups/#{group1.id}/online-venues"

        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
