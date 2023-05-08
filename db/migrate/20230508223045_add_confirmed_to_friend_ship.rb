class AddConfirmedToFriendShip < ActiveRecord::Migration[7.0]
  def change
    add_column :friendships, :confirmed?, :boolean, default: false
  end
end
