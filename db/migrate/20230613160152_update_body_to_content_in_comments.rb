class UpdateBodyToContentInComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.remove :body
      t.text :content
    end
  end
end
