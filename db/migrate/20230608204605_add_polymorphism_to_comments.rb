class AddPolymorphismToComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :post_id
      t.references :commentable, polymorphic: true
    end
  end
end
