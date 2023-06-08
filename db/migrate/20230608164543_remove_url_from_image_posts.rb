class RemoveUrlFromImagePosts < ActiveRecord::Migration[7.0]
  def change
    change_table :image_posts do |t|
      t.remove :url
    end
  end
end
