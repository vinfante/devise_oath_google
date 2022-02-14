class AddOmniauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
    # already had this field, this was added when using Google OAuth just to save this uid info from google
    # add_column :users, :uid, :string
    # add_index :users, :uid
  end
end
