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
          'start-at' => meetup.start_at.utc.strftime('%FT%H:%M:%S.%LZ'),
          'end-at'   => meetup.end_at.utc.strftime('%FT%H:%M:%S.%LZ'),
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

  describe 'POST /groups/{group-id}/meetups' do
    let!(:group)         { create(:group) }
    let!(:venue)         { create(:venue, group: group) }
    let!(:member)        { create(:member) }
    let!(:groups_member) { create(:groups_member, group: group, member: member) }

    let(:params) do
      {
        'title'    => 'テストミートアップ!',
        'start-at' => '2018-01-16T00:07:39.140Z',
        'end-at'   => '2018-01-16T00:09:39.140Z',
        'venue-id' => venue.id
      }
    end

    let(:expected_response_body) do
      {
        'event-id' => Integer,
        'title'    => 'テストミートアップ!',
        'start-at' => '2018-01-16T00:07:39.140Z',
        'end-at'   => '2018-01-16T00:09:39.140Z',
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
    end

    it 'ミートアップイベントを登録できること' do
      expect { post "/groups/#{group.id}/meetups", params: params }.to change(Meetup, :count).by 1

      aggregate_failures do
        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end

  describe 'GET /groups/{group-id}/meetups/{event-id}' do
    let!(:group)         { create(:group) }
    let!(:venue)         { create(:venue, group: group) }
    let!(:meetup)        { create(:meetup, group: group, venue: venue) }
    let!(:member)        { create(:member) }
    let!(:groups_member) { create(:groups_member, group: group, member: member) }

    let(:expected_response_body) do
      {
        'event-id' => meetup.id,
        'title'    => meetup.title,
        'start-at' => meetup.start_at.utc.strftime('%FT%H:%M:%S.%LZ'),
        'end-at'   => meetup.end_at.utc.strftime('%FT%H:%M:%S.%LZ'),
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
    end

    it '指定したミートアップイベント情報を取得できること' do
      get "/groups/#{group.id}/meetups/#{meetup.id}"

      aggregate_failures do
        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
