# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PlayedTimes', type: :request do
  describe 'GET /api/musics/board/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:musics) { create_list(:music, 3) }
    before do
      create(:score, music_id: musics[0].id, user_id: users[0].id, difficulty: :easy, played_times: 5, platform: :board)
      create(:score, music_id: musics[0].id, user_id: users[1].id, difficulty: :normal, platform: :board)
      create(:score, music_id: musics[0].id, user_id: users[2].id, difficulty: :hard, platform: :board)
      create(:score, music_id: musics[1].id, user_id: users[0].id, difficulty: :hard, platform: :board)
      create(:score, music_id: musics[2].id, user_id: users[1].id, difficulty: :hard, platform: :board)

      create(:score, music_id: musics[0].id, user_id: users[2].id, difficulty: :hard, platform: :button)
      create(:score, music_id: musics[1].id, user_id: users[0].id, difficulty: :hard, platform: :button)
      create(:score, music_id: musics[2].id, user_id: users[1].id, difficulty: :hard, platform: :button)
    end

    it 'return played times of three musics' do
      is_expected.to eq 200
      expect(json['data'].length).to eq 3
      expect(json['data'][0]['attributes']['times']).to eq 7
      expect(json['data'][1]['attributes']['times']).to eq 1
      expect(json['data'][2]['attributes']['times']).to eq 1
      expect(
        json['data'].map { |v| v['attributes']['platform'] }
      ).to all(eq 'board')
    end
  end

  describe 'GET /api/musics/:id/board/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:music) { create(:music) }
    before do
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :easy, played_times: 5, platform: :board)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :normal, platform: :board)
      create(:score, music_id: music.id, user_id: users[2].id, difficulty: :hard, platform: :board)
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :hard, platform: :board)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :hard, platform: :board)

      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :hard, platform: :button)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :hard, platform: :button)
    end
    let(:id) { music.id }

    it 'return played times of three difficulties' do
      is_expected.to eq 200
      expect(json['data']['attributes']['times']).to eq 9
      expect(json['data']['attributes']['platform']).to eq 'board'
    end
  end
end
