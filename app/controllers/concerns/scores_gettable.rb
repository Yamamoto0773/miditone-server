# frozen_string_literal: true

module ScoresGettable
  extend ActiveSupport::Concern

  def get_platform_scores(parent:)
    scores = if platform
      parent.scores.with_status(platform)
    else
      parent.scores
    end
  end
end
