class AddUserIdToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :user_id, :integer, {null: false, default: 1}

  end
end
