# frozen_string_literal: true

module ScoresGettable
  extend ActiveSupport::Concern

  def get_platform_scores(parent:)
    if platform
      parent.scores.with_platform(platform)
    else
      parent.scores
    end
  end
end
