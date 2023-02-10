# Stores custom fields values in JSONB type column
# Definition of custom fields lives in CustomField model
class User < ApplicationRecord
  has_many :custom_fields, dependent: :delete_all

  validates :full_name, presence: true

  after_initialize :setup_custom_fields

  private

  def setup_custom_fields
    setup_custom_fields_accessors(custom_fields)
    setup_custom_fields_validations(custom_fields)
  end

  def setup_custom_fields_accessors(fields)
    class_eval do
      store_accessor :custom_fields_data, *fields.pluck(:name)
    end
  end

  def setup_custom_fields_validations(fields)
    class_eval do
      fields.each do |field|
        validates field.name, field.validation_rules.deep_symbolize_keys unless field.validation_rules.blank?
      end
    end
  end
end
