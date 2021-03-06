require 'spec_helper'

describe Api::V2::UserSkillRatesController do
  describe 'GET #index' do
    let(:token) { AppConfig.api_token }
    let(:user) { create(:user, email: 'john.smith@netguru.pl') }
    let(:skill) { create(:skill) }
    let(:unknown_email) { 'asdasd@netguru.pl' }
    let!(:user_skill_rate) { create(:user_skill_rate, user: user, skill: skill, rate: 3) }
    let(:expected_array) do
      [
        { 'ref_name' => skill.ref_name.to_s, 'rate' => user_skill_rate.rate },
      ]
    end

    context 'without api token' do
      it 'returns response status 403' do
        get :index
        expect(response.status).to eq 403
      end
    end

    context 'with api token and invalid user_email' do
      before { get :index, token: token, user_email: unknown_email }

      it { expect(response.status).to eq(200) }

      it 'returns correct hash', :aggregate_failures do
        skill_rates = json_response['user_skill_rates']
        expect(skill_rates).to be_a(Array)
        expect(skill_rates.size).to eq(0)
      end
    end

    context 'with api token and valid user_email' do
      before { get :index, token: token, user_email: user.email }

      it_behaves_like 'returns correct hash and response is 200'
    end

    context 'with api token and user_email with different domain' do
      before { get :index, token: token, user_email: 'john.smith@netguru.co' }

      it_behaves_like 'returns correct hash and response is 200'
    end
  end
end
