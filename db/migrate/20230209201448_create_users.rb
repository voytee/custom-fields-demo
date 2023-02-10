class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.jsonb :custom_fields_data, null: false, default: {}, index: {using: :gin}
      t.timestamps
    end
  end
end
