# frozen_string_literal: true

module ScoresGettable
  extend ActiveSupport::Concern

  def get_platform_scores(parent:)
    if platform
      paginate(parent.scores.with_platform(platform))
    else
      paginate(parent.scores)
    end
  end
end
