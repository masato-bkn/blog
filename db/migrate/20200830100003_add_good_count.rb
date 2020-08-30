class AddGoodCount < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :good_count, :integer, :null => false, :default => 0
    add_column :comments, :good_count, :integer, :null => false, :default => 0
  end
end
