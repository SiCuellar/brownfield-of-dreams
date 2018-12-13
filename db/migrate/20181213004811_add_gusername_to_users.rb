class AddGusernameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gusername, :string
  end
end
