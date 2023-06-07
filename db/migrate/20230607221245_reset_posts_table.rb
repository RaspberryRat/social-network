class ResetPostsTable < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |t|
      t.remove :postable_id
      t.remove :postable_type
    end
  end
end
