class ChangeDatatypeContentOfArticles < ActiveRecord::Migration[6.0]
  def change
    change_column :articles, :content, 'text', default: nil
  end
end
