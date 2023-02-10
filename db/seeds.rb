u = User.create(full_name: 'John Doe')

u.custom_fields.create(
    name: 'nickname',
    field_type: :text,
    validation_rules: {presence: true, length: {minimum: 2, maximum: 32}}
  )

u.custom_fields.create(
    name: 'age',
    field_type: :number,
    validation_rules: {presence: true, numericality: {greater_than: 0, less_than: 130}}
  )

u.custom_fields.create(
    name: 'role',
    field_type: 'single_select',
    validation_rules: {presence: true},
    select_options: %w[admin editor reader]
  )

u.custom_fields.create(
    name: 'interests',
    validation_rules: {presence: true},
    field_type: 'multiple_select',
    select_options: %w[cars technology history]
  )
