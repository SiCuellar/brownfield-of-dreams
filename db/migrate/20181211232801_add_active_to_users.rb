class AddActiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :bool, :default => false 
  end
end
