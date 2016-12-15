class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_name(attribute_key_name, options = {})
    # *_id must have same human name for localized forms with references and admin area lists
    # *_before_type_cast must have same human name for meaningful format validation errors
    super(attribute_key_name.to_s.remove('_id', '_before_type_cast'), options)
  end
end
