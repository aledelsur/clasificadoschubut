class AddCarTruckAndMotoBrandToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :car_brand_id, :integer
    add_column :publications, :moto_brand_id, :integer
    add_column :publications, :truck_brand_id, :integer
    add_column :publications, :sub_subcategory_manual, :string
  end
end
