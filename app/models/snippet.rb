class Snippet < ApplicationRecord
  has_paper_trail
  validates_presence_of :slug, :text
end
