# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'GET /api/users' do
    it 'return two users' do
      is_expected.to eq 200
      expect(json['data'].length).to eq 2
    end
  end

  describe 'GET /api/users/:id' do
    let(:id) { user1.id }
    let!(:preference) { create(:preference, user_id: user1.id) }

    it 'return a user' do
      is_expected.to eq 200
      expect(json['data']['id']).to eq user1.id.to_s
      expect(json['included'][0]['id']).to eq preference.id.to_s
    end
  end

  describe 'POST /api/users' do
    let(:params) do
      {
        user: {
          name: 'abcde'
        }
      }
    end

    it 'create a user' do
      is_expected.to eq 201
    end
  end

  describe 'PUT /api/users/:id' do
    let(:id) { user1.id }
    let(:params) do
      {
        user: {
          name: 'renamed'
        }
      }
    end

    it 'update a user' do
      is_expected.to eq 200
      expect(json['data']['attributes']['name']).to eq 'renamed'
    end
  end

  describe 'DELETE /api/users/:id' do
    let(:id) { user1.id }

    it 'delete a user' do
      is_expected.to eq 204
    end
  end
end
