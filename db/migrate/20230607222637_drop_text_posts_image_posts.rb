class DropTextPostsImagePosts < ActiveRecord::Migration[7.0]
  def change
    drop_table :text_posts
    drop_table :image_posts
  end
end
