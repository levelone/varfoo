class RemoveUseridFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :user_id
    add_column :comments, :name, :string
  end
end