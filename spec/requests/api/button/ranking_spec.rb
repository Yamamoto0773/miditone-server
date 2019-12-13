# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:music) { create(:music) }
  let!(:score1) {
    create(:score, user_id: user1.id, music_id: music.id, difficulty: :hard, points: 700_000, platform: :button)
  }
  let!(:score2) {
    create(:score, user_id: user1.id, music_id: music.id, difficulty: :easy, points: 900_000, platform: :button)
  }
  let!(:score3) {
    create(:score, user_id: user2.id, music_id: music.id, difficulty: :normal, points: 900_000, platform: :button)
  }
  let!(:score4) {
    create(:score, user_id: user3.id, music_id: music.id, difficulty: :normal, points: 900_000, platform: :button)
  }
  let!(:board_score) {
    create(:score, user_id: user2.id, music_id: music.id, difficulty: :normal, points: 900_000, platform: :board)
  }

  describe 'GET /api/musics/:music_id/button/ranking' do
    let(:music_id) { music.id }

    context 'pass parameter \'difficulty\'' do
      let(:params) do
        {
          difficulty: 'normal'
        }
      end

      it 'return a score in easy difficulty' do
        is_expected.to eq 200
        expect(
          json['data'].map { |h| h['id'].to_i }
        ).to eq [score3.id, score4.id]
      end
    end

    context 'dont pass parameter \'difficulty\'' do
      it 'return three scores in order' do
        is_expected.to eq 200
        expect(json['data'].length).to eq 4
        expect(
          json['data'].map { |h| h['id'].to_i }
        ).to eq [score2.id, score3.id, score4.id, score1.id]
      end
    end
  end
end
