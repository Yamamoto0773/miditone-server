# frozen_string_literal: true

ApiPagination.configure do |config|
  config.paginator = :pagy
  config.page_param = :page
  config.per_page_param = :per_page
  config.include_total = false
  Pagy::VARS[:max_per_page] = 50
end
