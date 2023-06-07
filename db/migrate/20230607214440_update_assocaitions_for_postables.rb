class UpdateAssocaitionsForPostables < ActiveRecord::Migration[7.0]
  def change
    change_table :images do |t|
      t.remove :post_id
      t.references :post, polymorphic: true, index: true
    end

    change_table :texts do |t|
      t.remove :post_id
      t.references :post, polymorphic: true, index: true
    end

    change_table :posts do |t|
      t.remove :postable_id
      t.remove :postable_type
      t.references :postable, polymorphic: true, index: true
    end
  end
end

