# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  let!(:user) { create(:user) }
  let!(:music1) { create(:music) }
  let!(:music2) { create(:music) }
  let!(:score1) {
    create(:score, user_id: user.id, music_id: music2.id, difficulty: :hard, points: 600_000, platform: :board)
  }
  let!(:score2) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :easy, platform: :board)
  }
  let!(:score3) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :normal, platform: :board)
  }
  let!(:button_score) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :normal, points: 900_000, platform: :button)
  }
  let(:user_qrcode) { user.qrcode }

  describe 'GET /api/users/:user_qrcode/board/scores' do
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

  describe 'GET /api/users/:user_qrcode/board/scores/:id' do
    let(:id) { score1.id }

    it 'return a score' do
      is_expected.to eq 200
      expect(json['data']['id']).to eq score1.id.to_s
    end
  end

  describe 'POST /api/users/:user_qrcode/board/scores' do
    let(:params) do
      {
        score: {
          music_id: music2.id,
          difficulty: :normal,
          points: 700_000,
          max_combo: 200,
          critical_count: 300,
          correct_count: 50,
          nice_count: 10,
          miss_count: 1
        }
      }
    end

    it 'create a score' do
      is_expected.to eq 201
      expect(json['data']['attributes']['played_times']).to eq 1
    end
  end

  describe 'PUT /api/users/:user_qrcode/board/scores/:id' do
    context 'update score' do
      let(:id) { score1.id }
      let(:params) do
        {
          score: {
            points: 800_000,
            max_combo: 300,
            critical_count: 350,
            correct_count: 10,
            nice_count: 5,
            miss_count: 1
          }
        }
      end

      it 'update a score' do
        is_expected.to eq 200
        expect(json['data']['attributes']['points']).to eq 800_000
        expect(json['data']['attributes']['played_times']).to eq 2
      end
    end

    context 'dont update score' do
      let(:id) { score1.id }
      let(:params) do
        {
          score: {
            points: 400_000
          }
        }
      end

      it 'update a score' do
        is_expected.to eq 200
        expect(json['data']['attributes']['points']).to eq 600_000
        expect(json['data']['attributes']['played_times']).to eq 2
      end
    end
  end

  describe 'DELETE /api/users/:user_qrcode/board/scores/:id' do
    let(:id) { score1.id }

    it 'delete a score' do
      is_expected.to eq 204
    end
  end
end
