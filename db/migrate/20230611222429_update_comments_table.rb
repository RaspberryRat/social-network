class UpdateCommentsTable < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :commentable_type
      t.remove :commentable_id

      t.belongs_to :commentable, polymorphic: true, null: false
      t.integer :parent_id
    end
  end
end
