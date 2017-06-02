class Page < ApplicationRecord
  has_paper_trail
  validates_format_of :slug, with: /\A[a-z0-9\-_.]+\z/
  validates_presence_of :slug
end
