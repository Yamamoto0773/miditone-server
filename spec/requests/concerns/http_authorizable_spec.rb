# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HttpAuthorizable', type: :request do
  before do
    allow_any_instance_of(Api::BaseController).to receive(:authenticate!).and_call_original
  end

  let!(:token) { create(:token) }

  describe 'GET /api/health_check' do
    context 'with token' do
      let!(:headers) do
        {
          Authorization: "Bearer #{token.digest_hash}"
        }
      end

      it { is_expected.to eq 200 }
    end

    context 'with invalid token' do
      let!(:headers) do
        {
          Authorization: 'invalid token'
        }
      end

      it { is_expected.to eq 403 }
    end

    context 'with no token' do
      it { is_expected.to eq 403 }
    end
  end
end
