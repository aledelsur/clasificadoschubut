class AddUserIdToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :user_id, :integer
  end
end
