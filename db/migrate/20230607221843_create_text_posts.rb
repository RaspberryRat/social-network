class CreateTextPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :text_posts do |t|
      t.text :content
      t.references :post, polymorphic: true, null: false

      t.timestamps
    end
  end
end
