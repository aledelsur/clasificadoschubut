class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
