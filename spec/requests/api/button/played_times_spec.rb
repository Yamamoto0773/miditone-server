# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PlayedTimes', type: :request do
  describe 'GET /api/musics/button/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:musics) { create_list(:music, 3) }
    before do
      create(
        :score,
        music_id: musics[0].id, user_id: users[0].id, difficulty: :easy, played_times: 5, platform: :button
      )
      create(
        :score,
        music_id: musics[0].id, user_id: users[1].id, difficulty: :normal, platform: :button
      )
      create(
        :score,
        music_id: musics[0].id, user_id: users[2].id, difficulty: :hard, platform: :button
      )
      create(
        :score,
        music_id: musics[1].id, user_id: users[0].id, difficulty: :hard, platform: :button
      )
      create(
        :score,
        music_id: musics[2].id, user_id: users[1].id, difficulty: :hard, platform: :button
      )
    end

    it 'return played times of three musics' do
      is_expected.to eq 200
      expect(json[musics[0].id.to_s]).to eq 7
      expect(json[musics[1].id.to_s]).to eq 1
      expect(json[musics[2].id.to_s]).to eq 1
    end
  end

  describe 'GET /api/musics/:id/button/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:music) { create(:music) }
    before do
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :easy, played_times: 5, platform: :button)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :normal, platform: :button)
      create(:score, music_id: music.id, user_id: users[2].id, difficulty: :hard, platform: :button)
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :hard, platform: :button)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :hard, platform: :button)
    end
    let(:id) { music.id }

    it 'return played times of three difficulties' do
      is_expected.to eq 200
      expect(json['total']).to eq 9
      expect(json['easy']).to eq 5
      expect(json['normal']).to eq 1
      expect(json['hard']).to eq 3
    end
  end
end
