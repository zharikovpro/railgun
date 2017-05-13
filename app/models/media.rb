class Media < ApplicationRecord
  has_paper_trail

  has_attached_file :file
  do_not_validate_attachment_file_type :file
  validates_format_of :slug, with: /\A[a-z0-9\-_.]+\z/
end
