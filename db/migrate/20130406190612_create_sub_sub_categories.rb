class CreateSubSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_sub_categories do |t|
      t.integer :sub_category_id
      t.string :name
      t.string :key

      t.timestamps
    end
  end
end
