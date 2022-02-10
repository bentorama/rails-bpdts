require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe 'GET #index' do
    before do
      get :index
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected user attributes' do
      hash_body = JSON.parse(response.body).first
      expect(hash_body.keys).to match_array(['id', 'first_name', 'last_name', 'email', 'ip_address', 'latitude', 'longitude'])
    end
  end
end
