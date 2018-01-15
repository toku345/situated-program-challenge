require 'rails_helper'

describe 'venues API', type: :request do
  describe 'GET /groups/{group-id}/venues' do
    let(:group1) { create(:group) }
    let(:group2) { create(:group) }

    let!(:venue1_1) { create(:venue, group: group1) }
    let!(:venue1_2) { create(:venue, group: group1) }
    let!(:venue2_1) { create(:venue, group: group2) }

    let(:expected_response_body) do
      [
        {
          'venue-id'   => venue1_1.id,
          'venue-name' => venue1_1.name,
          'address' => {
            'postal-code' => venue1_1.postal_code,
            'prefecture'  => venue1_1.prefecture,
            'city'        => venue1_1.city,
            'address1'    => venue1_1.street1,
            'address2'    => venue1_1.street2
          }
        },
        {
          'venue-id'   => venue1_2.id,
          'venue-name' => venue1_2.name,
          'address' => {
            'postal-code' => venue1_2.postal_code,
            'prefecture'  => venue1_2.prefecture,
            'city'        => venue1_2.city,
            'address1'    => venue1_2.street1,
            'address2'    => venue1_2.street2
          }
        }
      ]
    end

    it '指定したグループに紐づく会場一覧を取得できること' do
      aggregate_failures do
        get "/groups/#{group1.id}/venues"

        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
