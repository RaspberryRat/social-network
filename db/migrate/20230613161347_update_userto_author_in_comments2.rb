class UpdateUsertoAuthorInComments2 < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :user_id
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
    end
  end
end
