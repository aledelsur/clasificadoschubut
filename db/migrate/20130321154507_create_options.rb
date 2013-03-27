class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :key
      t.text :text_value
      t.string  :string_value
      t.integer :int_value
      t.string :value_type

      t.timestamps
    end
  end
end