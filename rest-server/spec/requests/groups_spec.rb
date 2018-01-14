require 'rails_helper'

describe 'groups API', type: :request do
  describe 'GET /groups' do
    let!(:group) { create(:group) }

    # TODO: admin, venues, meetups は各リソースを追加したら詳細な値に置き換えること　
    let(:expected_response_body) do
      [
        {
          'group-id' => group.id,
          'group-name' => group.name,
          'admin' => [
            # {
            #   'member-id' => 0,
            #   'first-name' => 'string',
            #   'last-name' => 'string',
            #   'email' => 'string'
            # }
          ],
          'venues' => [
            # {
            #   'venue-id' => 0,
            #   'venue-name' => 'string',
            #   'address' => {
            #     'postal-code' => 'string',
            #     'prefecture' => 'string',
            #     'city' => 'string',
            #     'address1' => 'string',
            #     'address2' => 'string'
            #   }
            # }
          ],
          'meetups' => [
            # {
            #   'event-id' => 0,
            #   'title' => 'string',
            #   'start-at' => '2018-01-14T04 =>43 =>46.440Z',
            #   'end-at' => '2018-01-14T04 =>43 =>46.440Z',
            #   'venue' => {
            #     'venue-id' => 0,
            #     'venue-name' => 'string',
            #     'address' => {
            #       'postal-code' => 'string',
            #       'prefecture' => 'string',
            #       'city' => 'string',
            #       'address1' => 'string',
            #       'address2' => 'string'
            #     }
            #   },
            #   'members' => [
            #     {
            #       'member-id' => 0,
            #       'first-name' => 'string',
            #       'last-name' => 'string',
            #       'email' => 'string'
            #     }
            #   ]
            # }
          ]
        }
      ]
    end

    it 'グループ一覧情報を返却すること' do
      get '/groups'

      aggregate_failures do
        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
