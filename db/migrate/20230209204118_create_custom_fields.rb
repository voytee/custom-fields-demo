class CreateCustomFields < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_fields do |t|
      t.belongs_to :user, null: false, foreign_key: { delete: :cascade }
      t.string :name, null: false
      t.text :select_options, array: true, null: false, default: []
      t.integer :field_type, null: false, default: 0
      t.jsonb :validation_rules, default: {}
      t.timestamps
    end
  end
end
