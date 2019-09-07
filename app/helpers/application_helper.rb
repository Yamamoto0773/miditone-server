# frozen_string_literal: true

module ApplicationHelper
  # 単体でもクラスメソッドとしても使えるように

  module_function

  def random_number_str(n)
    (1..n).map { rand(10).to_s }.join
  end
end
