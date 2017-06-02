class Snippet < ApplicationRecord
  has_paper_trail

  validates_presence_of :slug
  validates_format_of :slug, with: /\A[a-z0-9\-_.]+\z/
end
