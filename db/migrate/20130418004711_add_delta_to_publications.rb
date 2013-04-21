class AddDeltaToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :delta, :boolean, :default => true,
      :null => false
  end
end
