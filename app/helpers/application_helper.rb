module ApplicationHelper
  include Pagy::Frontend

  ::Pagy::DEFAULT[:items] = 5
end
