# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Musics', type: :request do
  let!(:music1) { create(:music) }
  let!(:music2) { create(:music) }

  describe 'GET /api/musics' do
    it 'return two musics' do
      is_expected.to eq 200
      expect(json['data'].length).to eq 2
    end
  end

  describe 'GET /api/musics/:id' do
    let(:id) { music1.id }

    it 'return a music' do
      is_expected.to eq 200
      expect(json['data']['id']).to eq music1.id.to_s
    end
  end

  describe 'POST /api/musics' do
    let(:params) do
      {
        music: {
          title: 'title',
          artist: 'artist'
        }
      }
    end

    it 'create a music' do
      is_expected.to eq 201
    end
  end

  describe 'PUT /api/musics/:id' do
    let(:id) { music1.id }
    let(:params) do
      {
        music: {
          title: 'renamed'
        }
      }
    end

    it 'update a music' do
      is_expected.to eq 200
      expect(json['data']['attributes']['title']).to eq 'renamed'
    end
  end

  describe 'DELETE /api/musics/:id' do
    let(:id) { music1.id }

    it 'delete a music' do
      is_expected.to eq 204
    end
  end

  describe 'GET /api/musics/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:musics) { create_list(:music, 3) }
    before do
      create(:score, music_id: musics[0].id, user_id: users[0].id, difficulty: :easy, played_times: 5)
      create(:score, music_id: musics[0].id, user_id: users[1].id, difficulty: :normal)
      create(:score, music_id: musics[0].id, user_id: users[2].id, difficulty: :hard)
      create(:score, music_id: musics[1].id, user_id: users[0].id, difficulty: :hard)
      create(:score, music_id: musics[2].id, user_id: users[1].id, difficulty: :hard)
    end

    it 'return played times of three musics' do
      is_expected.to eq 200
      expect(json[musics[0].id.to_s]).to eq 7
      expect(json[musics[1].id.to_s]).to eq 1
      expect(json[musics[2].id.to_s]).to eq 1
    end
  end

  describe 'GET /api/musics/:music_id/played_times' do
    let!(:users) { create_list(:user, 3) }
    let!(:music) { create(:music) }
    before do
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :easy, played_times: 5)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :normal)
      create(:score, music_id: music.id, user_id: users[2].id, difficulty: :hard)
      create(:score, music_id: music.id, user_id: users[0].id, difficulty: :hard)
      create(:score, music_id: music.id, user_id: users[1].id, difficulty: :hard)
    end
    let(:music_id) { music.id }

    it 'return played times of three difficulties' do
      is_expected.to eq 200
      expect(json['total']).to eq 9
      expect(json['easy']).to eq 5
      expect(json['normal']).to eq 1
      expect(json['hard']).to eq 3
    end
  end
end
