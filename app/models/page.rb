class Page < ApplicationRecord
  has_paper_trail
  validates_format_of :slug, with: /([[:lower:]]|[0-9]+-?[[:lower:]])(-[[:lower:]0-9]+|[[:lower:]0-9])*/, message: :invalid_slug
end
