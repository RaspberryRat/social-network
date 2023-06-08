class CreateImageAndTextPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :image_posts do |t|
      t.references :post, null: false
      t.timestamps
    end

    create_table :text_posts do |t|
      t.references :post, null: false
      t.text :content
    end
  end
end
