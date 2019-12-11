# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  let!(:user) { create(:user) }
  let!(:music1) { create(:music) }
  let!(:music2) { create(:music) }
  let!(:score1) {
    create(
      :score,
      user_id: user.id,
      music_id: music2.id,
      difficulty: :hard,
      points: 600_000,
      max_combo: 50,
      platform: :button,
    )
  }
  let!(:score2) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :easy, platform: :button)
  }
  let!(:score3) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :normal, platform: :button)
  }
  let!(:board_score) {
    create(:score, user_id: user.id, music_id: music1.id, difficulty: :normal, points: 900_000, platform: :board)
  }
  let(:user_qrcode) { user.qrcode }

  describe 'GET /api/users/:user_qrcode/button/scores' do
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

  describe 'GET /api/users/:user_qrcode/button/scores/:id' do
    let(:id) { score1.id }

    it 'return a score' do
      is_expected.to eq 200
      expect(json['data']['id']).to eq score1.id.to_s
    end
  end


  describe 'PUT /api/users/:user_qrcode/button/scores/new_record' do
    let!(:music3) { create(:music) }

    context 'create record' do
      let(:params) do
        {
          score: {
            music_id: music3.id,
            difficulty: 'hard',
            points: 800_000,
            max_combo: 300,
            critical_count: 350,
            correct_count: 10,
            nice_count: 5,
            miss_count: 1,
          }
        }
      end

      it 'should be created score as new' do
        is_expected.to eq 200
        expect(json['data']['attributes']['played_times']).to eq 1
        expect(json['data']['attributes']['platform']).to eq 'button'
        expect(
          json['data']['attributes'].slice(*params[:score].keys)
        ).to eq params[:score].stringify_keys
      end
    end

    context 'update points' do
      let(:params) do
        {
          score: {
            music_id: music2.id,
            difficulty: 'hard',
            points: 800_000,
            max_combo: 40,
            critical_count: 350,
            correct_count: 10,
            nice_count: 5,
            miss_count: 1,
          }
        }
      end

      it 'should be updated score' do
        is_expected.to eq 200
        expect(json['data']['attributes']['played_times']).to eq 2
        expect(json['data']['attributes']['platform']).to eq 'button'
        expect(
          json['data']['attributes'].slice(*params[:score].except(:max_combo).keys)
        ).to eq params[:score].except(:max_combo).stringify_keys
        expect(
          json['data']['attributes']['max_combo']
        ).to eq 50
      end
    end

    context 'update max combo' do
      let(:params) do
        {
          score: {
            music_id: music2.id,
            difficulty: 'hard',
            points: 300_000,
            max_combo: 100,
            critical_count: 350,
            correct_count: 10,
            nice_count: 5,
            miss_count: 1,
          }
        }
      end

      it 'should be max combo' do
        expect {
          is_expected.to eq 200
        }.not_to(change {
          score1.attributes.except(:max_combo)
        })
        expect(json['data']['attributes']['played_times']).to eq 2
        expect(json['data']['attributes']['platform']).to eq 'button'
        expect(
          json['data']['attributes']['max_combo']
        ).to eq 100
      end
    end

    context 'dont update record' do
      let(:params) do
        {
          score: {
            music_id: music2.id,
            difficulty: 'hard',
            points: 400_000,
            max_combo: 10,
            critical_count: 350,
            correct_count: 10,
            nice_count: 5,
            miss_count: 1,
          }
        }
      end

      it 'should not be updated score but incremented play times' do
        is_expected.to eq 200
        expect(json['data']['attributes']['played_times']).to eq 2
        expect(json['data']['attributes']['platform']).to eq 'button'
        expect(json['data']['attributes']['points']).to eq 600_000
        expect(json['data']['attributes']['max_combo']).to eq 50
      end
    end
  end

  describe 'DELETE /api/users/:user_qrcode/button/scores/:id' do
    let(:id) { score1.id }

    it 'delete a score' do
      is_expected.to eq 204
    end
  end
end
