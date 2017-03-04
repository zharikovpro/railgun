module EnumI18nHelper
  # Returns an array of the possible key/i18n values for the enum
  # enum_options_for_select(User, :role)
  def enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      [enum_i18n(class_name, enum, key), key]
    end
  end

  # Returns the i18n version of the enum value
  # enum_value_i18n(user, :role)
  def enum_value_i18n(model, enum)
    enum_i18n(model.class, enum, model.send(enum))
  end

  # Returns the i18n string for the enum key
  # enum_i18n(User, :role, :admin)
  def enum_i18n(class_name, enum, key)
    I18n.t("activerecord.attributes.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end
end
