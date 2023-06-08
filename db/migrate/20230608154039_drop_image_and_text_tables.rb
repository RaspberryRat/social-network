class DropImageAndTextTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :image_posts
    drop_table :text_posts
  end
end
