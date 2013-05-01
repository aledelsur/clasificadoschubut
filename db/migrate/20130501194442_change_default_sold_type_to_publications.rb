class ChangeDefaultSoldTypeToPublications < ActiveRecord::Migration
  def up
      change_column :publications, :sold, :boolean, :default => false
  end

  def down
      change_column :publications, :sold, :boolean, :default => nil
  end
end
