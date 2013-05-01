class AddHasTitleToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :has_title, :boolean, :default => 0
  end
end
