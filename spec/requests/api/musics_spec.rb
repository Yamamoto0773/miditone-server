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
end
