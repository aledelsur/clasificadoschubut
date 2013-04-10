class AddSubSubCategoryToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :sub_sub_category_id, :integer
  end
end
