class AddStatusAndUrgentToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :status, :string
    add_column :publications, :urgent, :boolean
  end
end
