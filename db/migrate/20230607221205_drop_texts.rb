class DropTexts < ActiveRecord::Migration[7.0]
  def change
    drop_table :texts
  end
end
