class ConvertPoststoImageAndTextWithPolymorphism < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.references :post, null: false, foreign_key: true
    end
  end

  create_table :texts do |t|
    t.references :post, null: false, foreign_key: true
    t.string :content
  end

  change_table :posts do |t|
    t.remove :content
    t.references :postable, polymorphic: true
  end
end
