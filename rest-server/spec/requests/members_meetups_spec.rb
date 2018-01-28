require 'rails_helper'

describe 'members_meetups API', type: :request do
  describe 'POST /members/{member-id}/meetups/{event-id}' do
    let!(:member)        { create(:member) } # グループ非加入メンバーだけどミートアップ参加 => responseに含まれない
    let!(:member2)       { create(:member) } # グループ加入済みだけどミートアップ非参加 => responseに含まれない
    let!(:group)         { create(:group) }
    let!(:groups_member) { create(:groups_member, group: group, member: member2) }
    let!(:venue)         { create(:physical_venue, group: group) }
    let!(:online_venue)  { create(:online_venue, group: group) }
    let!(:meetup)        { create(:meetup, group: group, venue: venue, online_venue: online_venue) }

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

    it 'メンバーが指定したグループに参加できること' do
      aggregate_failures do
        expect do
          post "/members/#{member.id}/meetups/#{meetup.id}"
        end.to change(MeetupsMember, :count).by 1

        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
