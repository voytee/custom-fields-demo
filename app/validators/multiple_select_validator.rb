# It validates custom multiple_select field whether
# all the selected values are from the list of provided possible values
# Uses inclusion key for error message
class MultipleSelectValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless options.key?(:in)
    return if value.blank?

    record.errors.add(attribute, :inclusion) if (options[:in] | value).size != options[:in].size
  end
end
