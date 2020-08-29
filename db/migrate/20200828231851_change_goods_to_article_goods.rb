class ChangeGoodsToArticleGoods < ActiveRecord::Migration[6.0]
  def change
    rename_table :goods, :article_goods
  end
end
