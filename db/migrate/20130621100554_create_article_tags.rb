class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :articles_tags do |t|
      t.belongs_to :tag
      t.belongs_to :article

      t.timestamps
    end
    add_index :articles_tags, :tag_id
    add_index :articles_tags, :article_id
  end
end
