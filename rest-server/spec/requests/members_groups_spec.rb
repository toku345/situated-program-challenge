require 'rails_helper'

describe 'members_groups API', type: :request do
  describe 'POST /members/{member-id}/groups/{group-id}' do
    context 'admin = true のとき' do
      let(:member) { create(:member) }
      let(:group)  { create(:group) }

      let!(:venue)        { create(:physical_venue, group: group) }
      let!(:online_venue) { create(:online_venue, group: group) }
      let!(:meetup) do
        create(:meetup, group: group, venue: venue, online_venue: online_venue)
      end

      let!(:meetups_member) { create(:meetups_member, meetup: meetup, member: member) }

      let(:expected_response_body) do
        {
          'group-id'   => group.id,
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
              'online-venue' =>
              {
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
      end

      it 'メンバーが指定したグループに参加できること' do
        aggregate_failures do
          expect do
            post "/members/#{member.id}/groups/#{group.id}", params: { admin: true }
          end.to change(GroupsMember, :count).by 1

          expect(response).to be_success
          expect(response.body).to be_json_as(expected_response_body)
        end
      end
    end

    context 'admin = false のとき' do
      let(:member) { create(:member) }
      let(:group)  { create(:group) }

      let!(:venue)        { create(:physical_venue, group: group) }
      let!(:online_venue) { create(:online_venue, group: group) }
      let!(:meetup) do
        create(:meetup, group: group, venue: venue, online_venue: online_venue)
      end

      let!(:meetups_member) { create(:meetups_member, meetup: meetup, member: member) }

      let(:expected_response_body) do
        {
          'group-id'   => group.id,
          'group-name' => group.name,
          'admin' => [], # 空
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
      end

      it 'メンバーが指定したグループに参加できること' do
        aggregate_failures do
          expect do
            post "/members/#{member.id}/groups/#{group.id}", params: { admin: false }
          end.to change(GroupsMember, :count).by 1

          expect(response).to be_success
          expect(response.body).to be_json_as(expected_response_body)
        end
      end
    end

    context '同一メンバー・グループで複数回APIを叩かれたとき' do
      let(:member) { create(:member) }
      let(:group)  { create(:group) }

      it '新しいレコードを作成せず、admin情報も更新しないこと' do
        aggregate_failures do
          # 1回目
          post "/members/#{member.id}/groups/#{group.id}", params: { admin: false }
          expect(GroupsMember.first.admin).to be_falsey

          # 2回目
          expect do
            post "/members/#{member.id}/groups/#{group.id}", params: { admin: true }
          end.not_to change(GroupsMember, :count)
          expect(GroupsMember.first.admin).to be_falsey # 2回目以降はadminは更新しない(仮設計)

          # 3回目
          expect do
            post "/members/#{member.id}/groups/#{group.id}", params: { admin: true }
          end.not_to change(GroupsMember, :count)
          expect(GroupsMember.first.admin).to be_falsey # 2回目以降はadminは更新しない(仮設計)
        end
      end
    end
  end
end
