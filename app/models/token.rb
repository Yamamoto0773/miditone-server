# frozen_string_literal: true

class Token < ApplicationRecord
  validates :name, :digest_hash,
    presence: true,
    uniqueness: true

  def key=(key)
    @key = key
    self.digest_hash = Digest::SHA512.hexdigest(key)
  end

  # https://github.com/rails/rails/pull/35280
  # https://blog.kamipo.net/entry/2019/05/15/152652
  # とりあえずクラスメソッドを代わりに使う
  def self.authenticated?(token)
    Token.exists?(digest_hash: token)
  end
end
