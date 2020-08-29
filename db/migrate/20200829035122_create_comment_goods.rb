class CreateCommentGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_goods do |t|
      t.integer :user_id, null: false
      t.integer :comment_id, null: false
      t.timestamps
    end

    add_index :comment_goods, [:user_id, :comment_id], unique: true
  end
end
