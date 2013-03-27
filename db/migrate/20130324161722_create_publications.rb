class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.integer  :city_id
      t.integer  :sub_category_id
      t.string  :title
      t.float   :price
      t.string  :i_am
      t.text    :description
      t.string  :currency
      t.string  :email
      t.string  :phone
      t.string  :brand
      t.string  :model
      t.string  :year
      t.string  :condition
      t.string  :km
      t.string  :color
      t.string  :fuel
      t.boolean :sold

      t.timestamps
    end
  end
end
