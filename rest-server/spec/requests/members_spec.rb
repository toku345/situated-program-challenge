require 'rails_helper'

describe 'members API', type: :request do
  describe 'GET /members' do
    let!(:member1) { create(:member) }
    let!(:member2) { create(:member) }

    let(:expected_response_body) do
      [
        {
          'member-id'  => member1.id,
          'first-name' => member1.first_name,
          'last-name'  => member1.last_name,
          'email'      => member1.email
        },
        {
          'member-id'  => member2.id,
          'first-name' => member2.first_name,
          'last-name'  => member2.last_name,
          'email'      => member2.email
        }
      ]
    end

    it 'メンバー一覧情報を返却すること' do
      get '/members'

      aggregate_failures do
        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end

  describe 'POST /members' do
    subject do
      post '/members',
           params: { 'first-name' => 'Rich', 'last-name' => 'Hickey', 'email' => 'rich@sample.com' }
    end

    let!(:expected_response_body) do
      {
        'member-id'  => Integer,
        'first-name' => 'Rich',
        'last-name'  => 'Hickey',
        'email'      => 'rich@sample.com'
      }
    end

    it 'メンバー情報を登録できること' do
      aggregate_failures do
        expect { subject }.to change(Member, :count).by(1)

        expect(response).to be_success
        expect(response.body).to be_json_as(expected_response_body)
      end
    end
  end
end
