# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Preferences', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /api/users/:user_qrcode/button/preference' do
    let(:user_qrcode) { user.qrcode }

    it 'return user\'s button preference' do
      is_expected.to eq 200
      expect(json['data']['attributes']['platform']).to eq 'button'
    end
  end

  describe 'PUT /api/users/:user_qrcode/button/preference' do
    let(:user_qrcode) { user.qrcode }
    let(:params) do
      {
        preference: {
          note_speed: 6.5,
          se_volume: 5
        }
      }
    end

    it 'update board preference' do
      is_expected.to eq 200
      expect(json['data']['attributes']['note_speed']).to eq 6.5
      expect(json['data']['attributes']['se_volume']).to eq 5
    end
  end
end
