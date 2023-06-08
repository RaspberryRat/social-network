class CreateTextAndImagePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :text_posts do |t|
      t.text :content
      t.timestamps
    end

    create_table :image_posts do |t|
      t.string :url
      t.timestamps
    end
  end
end
