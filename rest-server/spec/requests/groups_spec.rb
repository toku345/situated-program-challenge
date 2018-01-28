require 'rails_helper'

describe 'groups API', type: :request do
  describe 'GET /groups' do
    let!(:groups_member) { create(:groups_member, admin: true) }
    let(:group)          { groups_member.group }
    let(:member)         { groups_member.member }

    let!(:venue)        { create(:physical_venue, group: group) }
    let!(:online_venue) { create(:online_venue, group: group) }
    let!(:meetup)       { create(:meetup, group: group, venue: venue, online_venue: online_venue) }

    let!(:meetups_member) { create(:meetups_member, meetup: meetup, member: member) }

    let(:expected_response_body) do
      [
        {
          'group-id' =>   group.id,
          'group-name' => group.name,
          'admin' => [
            {
              'member-id'  => member.id,
              'first-name' => member.first_name,
              'last-name'  => member.last_name,
              'email'      => member.email
            }
          ],
          'venues' => [
            {
              'venue-id'   => venue.id,
              'venue-name' => venue.name,
              'address' => {
                'postal-code' => venue.postal_code,
                'prefecture'  => venue.prefecture,
                'city'        => venue.city,
                'address1'    => venue.street1,
                'address2'    => venue.street2
              }
            }
          ],
          'online-venues' => [
            {
              'online-venue-id' => online_venue.id,
              'venue-name'      => online_venue.name,
              'url'             => online_venue.url
            }
          ],
          'meetups' => [
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

    it '複数groups返却できること' do
      create(:group)
      get '/groups'

      groups = JSON.parse(response.body)
      expect(groups.count).to be 2
    end
  end

  describe 'POST /groups' do
    let(:member1) { create(:member) }
    let(:member2) { create(:member) }

    let(:expected_response_body) do
      {
        'group-id' =>   Integer,
        'group-name' => 'TEST GROUP',
        'admin' => [
          {
            'member-id' =>  member1.id,
            'first-name' => member1.first_name,
            'last-name' =>  member1.last_name,
            'email' =>      member1.email
          },
          {
            'member-id' =>  member2.id,
            'first-name' => member2.first_name,
            'last-name' =>  member2.last_name,
            'email' =>      member2.email
          }
        ]
      }
    end

    it 'グループを登録できること' do
      aggregate_failures do
        expect do
          post '/groups', params: { 'group-name' => 'TEST GROUP',
                                    'admin-member-ids' => [member1.id, member2.id] }
        end.to change(Group, :count).by 1

        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end

    it 'adminメンバーを適切に登録できること' do
      expect do
        post '/groups', params: { 'group-name' => 'TEST GROUP',
                                  'admin-member-ids' => [member1.id, member2.id] }
      end.to change(GroupsMember, :count).by 2
    end
  end
end
