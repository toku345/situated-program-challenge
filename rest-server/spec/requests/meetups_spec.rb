require 'rails_helper'

describe 'meetups API', type: :request do
  describe 'GET /groups/{group-id}/meetups' do
    let!(:group)         { create(:group) }
    let!(:venue)         { create(:venue, group: group) }
    let!(:meetup)        { create(:meetup, group: group, venue: venue) }
    let!(:member)        { create(:member) }
    let!(:groups_member) { create(:groups_member, group: group, member: member) }

    let(:expected_response_body) do
      [
        {
          'event-id' => meetup.id,
          'title'    => meetup.title,
          'start-at' => meetup.start_at.rfc3339, # `2018-01-16T00:27:42.798Z` スタイル
          'end-at'   => meetup.end_at.rfc3339,
          'venue' => {
            'venue-id'   => venue.id,
            'venue-name' => venue.name,
            'address' => {
              'postal-code' => venue.postal_code,
              'prefecture'  => venue.prefecture,
              'city'        => venue.city,
              'address1'    => venue.street1,
              'address2'    => venue.street2
            }
          },
          'members' => [
            {
              'member-id'  => member.id,
              'first-name' => member.first_name,
              'last-name'  => member.last_name,
              'email'      => member.email
            }
          ]
        }
      ]
    end

    it 'ミートアップイベント一覧を取得できること' do
      get "/groups/#{group.id}/meetups"

      aggregate_failures do
        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
