# frozen_string_literal: true

namespace :token do
  task :create, ['name', 'key'] => :environment do |_task, args|
    if args[:name].nil?
      p '[ERROR] Please pass token name'
    elsif args[:key].nil?
      p '[ERROR] Please pass token key'
    else
      token = Token.new(name: args[:name], key: args[:key])
      token.save!

      p token.digest_hash
    end
  end
end
