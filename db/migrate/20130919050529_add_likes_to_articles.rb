class AddLikesToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :likes_count, :integer, default: 0
  end
end
