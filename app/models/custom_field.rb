# Defines custom fields for User
# Possible types of fields: text, number, single_select, multiple_select
# Column: select_options holds the array of possible values for single and multiple select fields
# Column validation_rules contains hash-like standard rails validation definitions
# like for example: {length: {minimum: 1, maximum: 50}}
# Number, single_select, and multiple_select fields are set also with default validation rules
# ensuring basic correctness of data (see: CustomField#default_validation_rules)
# Note: multiple_select uses custom validator (see: app/validators/multiple_select_validator.rb)
class CustomField < ApplicationRecord
  belongs_to :user

  validates :name, :field_type, presence: true

  enum :field_type, %i[text number single_select multiple_select]

  def validation_rules
    default_validation_rules[field_type].deep_merge(super)
  end

  private

  # Provides default validation rules to ensure:
  # - numericality for number field
  # - inclusion for single_select
  # - inclusion for multiple_select (custom validator that checks if all selected options are from provided options)
  def default_validation_rules
    rules= Hash.new({})
    rules[:number] = {numericality: {allow_nil: true}}
    rules[:single_select] = {inclusion: {in: select_options}}
    rules[:multiple_select] = {multiple_select: {in: select_options}}

    rules.with_indifferent_access
  end
end
