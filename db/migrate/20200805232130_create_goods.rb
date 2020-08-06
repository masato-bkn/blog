class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.integer :user_id
      t.integer :article_id
      t.timestamps
    end

    add_index :goods, [:user_id, :article_id], unique: true
  end
end
