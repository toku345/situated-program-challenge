require 'rails_helper'

describe 'meetups API', type: :request do
  describe 'GET /groups/{group-id}/meetups' do
    let!(:group) { create(:group) }

    let!(:venue)        { create(:physical_venue, group: group) }
    let!(:online_venue) { create(:online_venue, group: group) }
    let!(:meetup)       { create(:meetup, group: group, venue: venue, online_venue: online_venue) }

    let!(:member)         { create(:member) } # グループ非加入だけどミートアップ参加メンバー => responseに含まれる
    let!(:meetups_member) { create(:meetups_member, meetup: meetup, member: member) }
    let!(:member2)        { create(:member) } # グループ加入済みだけどミートアップ非参加 => responseに含まれない
    let!(:groups_member)  { create(:groups_member, group: group, member: member2) }

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
          'online-venue' => {
            'online-venue-id' => online_venue.id,
            'venue-name'      => online_venue.name,
            'url'             => online_venue.url
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
    let!(:venue)         { create(:physical_venue, group: group) }
    let!(:online_venue)  { create(:online_venue, group: group) }
    let!(:member)        { create(:member) }
    let!(:groups_member) { create(:groups_member, group: group, member: member) }

    let(:params) do
      {
        'title'           => 'テストミートアップ!',
        'start-at'        => '2018-01-16T00:07:39.140Z',
        'end-at'          => '2018-01-16T00:09:39.140Z',
        'venue-id'        => venue.id,
        'online-venue-id' => online_venue.id
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
        'online-venue' => {
          'online-venue-id' => online_venue.id,
          'venue-name'      => online_venue.name,
          'url'             => online_venue.url
        },
        'members' => []
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
    let!(:group) { create(:group) }

    let!(:venue)        { create(:physical_venue, group: group) }
    let!(:online_venue) { create(:online_venue, group: group) }
    let!(:meetup)       { create(:meetup, group: group, venue: venue, online_venue: online_venue) }

    let!(:member)         { create(:member) } # グループ非加入だけどミートアップ参加メンバー => responseに含まれる
    let!(:meetups_member) { create(:meetups_member, meetup: meetup, member: member) }
    let!(:member2)        { create(:member) } # グループ加入済みだけどミートアップ非参加 => responseに含まれない
    let!(:groups_member)  { create(:groups_member, group: group, member: member2) }

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
        'online-venue' => {
          'online-venue-id' => online_venue.id,
          'venue-name'      => online_venue.name,
          'url'             => online_venue.url
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
