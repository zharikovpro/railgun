class Media < ApplicationRecord
  has_attached_file :file
  validates_attachment_presence :file
  do_not_validate_attachment_file_type :file
end
