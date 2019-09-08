# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  let!(:user) { create(:user) }
  let!(:music1) { create(:music) }
  let!(:music2) { create(:music) }
  let!(:score1) { create(:score, user_id: user.id, music_id: music2.id, difficulty: :hard) }
  let!(:score2) { create(:score, user_id: user.id, music_id: music1.id, difficulty: :easy) }
  let!(:score3) { create(:score, user_id: user.id, music_id: music1.id, difficulty: :normal) }

  describe 'GET /api/users/:user_id/scores' do
    let(:user_id) { user.id }

    context 'pass parameter \'difficulty\'' do
      let(:params) do
        {
          difficulty: 'easy'
        }
      end

      it 'return a score in easy difficulty' do
        is_expected.to eq 200
        expect(json['data'].length).to eq 1
        expect(json['data'][0]['id']).to eq score2.id.to_s
      end
    end

    context 'dont pass parameter \'difficulty\'' do
      it 'return three scores in order' do
        is_expected.to eq 200
        expect(json['data'].length).to eq 3
        expect(json['data'][0]['id']).to eq score2.id.to_s
        expect(json['data'][1]['id']).to eq score3.id.to_s
        expect(json['data'][2]['id']).to eq score1.id.to_s
      end
    end
  end

  describe 'GET /api/scores/:id' do
    let(:id) { score1.id }

    it 'return a score' do
      is_expected.to eq 200
      expect(json['data']['id']).to eq score1.id.to_s
    end
  end

  describe 'POST /api/users/:user_id/scores' do
    let(:user_id) { user.id }
    let(:params) do
      {
        score: {
          music_id: music2.id,
          difficulty: :normal,
          points: 700_000
        }
      }
    end

    it 'create a score' do
      is_expected.to eq 201
    end
  end

  describe 'PUT /api/scores/:id' do
    let(:id) { score1.id }
    let(:params) do
      {
        score: {
          points: 800_000
        }
      }
    end

    it 'update a score' do
      is_expected.to eq 200
      expect(json['data']['attributes']['points']).to eq 800_000
    end
  end

  describe 'DELETE /api/scores/:id' do
    let(:id) { score1.id }

    it 'delete a score' do
      is_expected.to eq 204
    end
  end
end
