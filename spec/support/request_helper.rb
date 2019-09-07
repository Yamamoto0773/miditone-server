# frozen_string_literal: true

module RequestHelper
  def json
    # シンボルキーと文字列キーを同じとして扱う
    ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(response.body)) if response.body.present?
  end
end
