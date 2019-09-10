# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Scores', type: :request do
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:music) { create(:music) }
  let!(:score1) { create(:score, user_id: user1.id, music_id: music.id, difficulty: :hard, points: 700_000) }
  let!(:score2) { create(:score, user_id: user1.id, music_id: music.id, difficulty: :easy, points: 900_000) }
  let!(:score3) { create(:score, user_id: user2.id, music_id: music.id, difficulty: :normal, points: 900_000) }

  describe 'GET /api/musics/:music_id/ranking' do
    let(:music_id) { music.id }

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
end
