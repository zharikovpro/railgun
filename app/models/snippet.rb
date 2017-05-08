class Snippet < ApplicationRecord
  has_paper_trail
  validates_format_of :slug, with: /\A[a-z0-9\-_.]+\z/
end
