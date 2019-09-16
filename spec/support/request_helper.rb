# frozen_string_literal: true

module RequestHelper
  extend ActiveSupport::Concern

  included do
    before do
      allow_any_instance_of(Api::BaseController).to receive(:authenticate!)
    end
  end

  def json
    # シンボルキーと文字列キーを同じとして扱う
    ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(response.body)) if response.body.present?
  end
end
