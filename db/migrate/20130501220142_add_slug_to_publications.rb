class AddSlugToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :slug, :string
  end
end
